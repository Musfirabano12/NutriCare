# app/routers/pass_reset.py
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from app import schemas, crud_auth, auth_utils
from app.database import get_db
from app.email_service import email_service
import hashlib

router = APIRouter(prefix="/auth", tags=["auth"])

@router.post("/forgot-password", response_model=schemas.PasswordResetTokenResponse)
async def forgot_password(payload: schemas.ForgotPasswordRequest, db: AsyncSession = Depends(get_db)):
    user = await crud_auth.get_user_by_email(db, payload.email)

    if not user:
        return {
            "message": "If your email is registered, you will receive a password reset link.",
            "token_sent": False
        }

    raw_token, token_hash = auth_utils.generate_password_reset_token()
    expires_at = auth_utils.get_password_reset_expiry()

    await crud_auth.create_password_reset_token(db, user.user_id, token_hash, expires_at)

    user_name = user.first_name or user.email.split("@")[0]
    email_sent = await email_service.send_reset_password_email(user.email, raw_token, user_name)

    return {
        "message": "Password reset email sent. Check your inbox.",
        "token_sent": True
    }

@router.post("/reset-password", response_model=schemas.ResetPasswordResponse)
async def reset_password(payload: schemas.ResetPasswordRequest, db: AsyncSession = Depends(get_db)):
    token_hash = hashlib.sha256(payload.token.encode("utf-8")).hexdigest()
    reset_token = await crud_auth.get_password_reset_token(db, token_hash)

    if not reset_token or reset_token.used:
        raise HTTPException(status_code=400, detail="Invalid or expired reset token.")

    new_password_hash = auth_utils.hash_password(payload.new_password)
    updated_user = await crud_auth.update_user_password(db, reset_token.user_id, new_password_hash)
    await crud_auth.mark_password_reset_token_used(db, reset_token.token_id)

    return {"message": "Password reset successful! You can now log in.", "success": True}

@router.get("/validate-reset-token")
async def validate_reset_token(token: str, db: AsyncSession = Depends(get_db)):
    token_hash = hashlib.sha256(token.encode("utf-8")).hexdigest()
    reset_token = await crud_auth.get_password_reset_token(db, token_hash)

    if not reset_token:
        raise HTTPException(status_code=400, detail="Invalid or expired token")

    return {"valid": True, "expires_at": reset_token.expires_at.isoformat()}
