from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from datetime import datetime, timedelta
from app import schemas, crud_auth, auth_utils
from app.database import get_db
from jose import jwt, JWTError
import hashlib

router = APIRouter(prefix="/auth", tags=["auth"])

@router.post("/register", response_model=schemas.TokenResponse)
async def register(payload: schemas.UserCreate, db: AsyncSession = Depends(get_db)):

    existing = await crud_auth.get_user_by_email(db, payload.email)
    if existing:
        raise HTTPException(status_code=400, detail="Email already registered")

    user = await crud_auth.create_user(
        db,
        payload.email,
        payload.first_name,
        payload.last_name,
        payload.password
    )

    if user is None:
        raise HTTPException(
            status_code=500,
            detail="User creation failed (DB error)"
        )

    access_token = auth_utils.create_access_token(subject=user.user_id)
    raw_refresh, token_hash = auth_utils.generate_refresh_token_pair()

    expires_at = datetime.utcnow() + timedelta(days=30)
    await crud_auth.create_refresh_token(db, user.user_id, token_hash, expires_at)

    return {
        "access_token": access_token,
        "refresh_token": raw_refresh,
        "expires_at": expires_at
    }


@router.post("/login", response_model=schemas.TokenResponse)
async def login(payload: schemas.LoginRequest, db: AsyncSession = Depends(get_db)):
    user = await crud_auth.get_user_by_email(db, payload.email)
    if not user:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid credentials")
    if not auth_utils.verify_password(payload.password, user.password_hash):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid credentials")
    access_token = auth_utils.create_access_token(subject=user.user_id)
    raw_refresh, token_hash = auth_utils.generate_refresh_token_pair()
    expires_at = datetime.utcnow() + timedelta(days=30)
    await crud_auth.create_refresh_token(db, user.user_id, token_hash, expires_at)
    return {"access_token": access_token, "refresh_token": raw_refresh, "expires_at": expires_at}


@router.post("/refresh", response_model=schemas.TokenResponse)
async def refresh(req: schemas.RefreshRequest, db: AsyncSession = Depends(get_db)):
    # hash incoming token and find it
    token_hash = hashlib.sha256(req.refresh_token.encode("utf-8")).hexdigest()
    rt = await crud_auth.get_refresh_token_by_hash(db, token_hash)
    if not rt:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid refresh token")
    if rt.revoked:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Refresh token revoked")
    if rt.expires_at < datetime.utcnow():
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Refresh token expired")
    # create new access token (we can rotate refresh tokens, here we keep same refresh token)
    access_token = auth_utils.create_access_token(subject=rt.user_id)
    return {"access_token": access_token, "refresh_token": req.refresh_token}


@router.post("/logout")
async def logout(req: schemas.RefreshRequest, db: AsyncSession = Depends(get_db)):
    token_hash = hashlib.sha256(req.refresh_token.encode("utf-8")).hexdigest()
    rt = await crud_auth.get_refresh_token_by_hash(db, token_hash)
    if not rt:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Invalid refresh token")
    await crud_auth.revoke_refresh_token(db, rt.token_id)
    return {"detail": "logged out"}

