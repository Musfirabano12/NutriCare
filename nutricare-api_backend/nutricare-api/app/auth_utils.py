from passlib.context import CryptContext
from jose import JWTError,jwt
from datetime import datetime, timedelta
import hashlib, uuid
from sqlalchemy import select
from .config import settings
from fastapi.security import OAuth2PasswordBearer
from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from sqlalchemy.ext.asyncio import AsyncSession
from .database import get_db
from . import models

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/auth/login", auto_error=True)
auth_scheme = HTTPBearer()

pwd_context = CryptContext(schemes=["argon2", "bcrypt"], deprecated="auto")

# ======================================
# User Auth Utils
# ======================================

def hash_password(password: str) -> str:
    """
    Hash password with the default scheme (argon2).
    Truncate only if using bcrypt internally.
    """
    # Detect if the default scheme is bcrypt
    if pwd_context.default_scheme() == "bcrypt":
        truncated = password.encode("utf-8")[:72]
        return pwd_context.hash(truncated)
    return pwd_context.hash(password)

def verify_password(plain_password: str, hashed_password: str) -> bool:
    try:
        if hashed_password.startswith("$2a$") or hashed_password.startswith("$2b$"):
            truncated = plain_password.encode("utf-8")[:72]
            return pwd_context.verify(truncated, hashed_password)
        return pwd_context.verify(plain_password, hashed_password)
    except Exception as e:
        # Log and return False instead of crashing
        print("Password verify error:", e)
        return False

def create_access_token(subject: str | int, expires_minutes: int | None = None) -> str:
    now = datetime.utcnow()
    if expires_minutes is None:
        expires_minutes = settings.ACCESS_TOKEN_EXPIRE_MINUTES
    expire = now + timedelta(minutes=expires_minutes)
    payload = {"sub": str(subject), "iat": now, "exp": expire}
    token = jwt.encode(payload, settings.JWT_SECRET, algorithm=settings.JWT_ALGORITHM)
    return token

def generate_refresh_token_pair():
    raw = str(uuid.uuid4())
    token_hash = hashlib.sha256(raw.encode("utf-8")).hexdigest()
    return raw, token_hash


async def get_current_user(
    credentials: HTTPAuthorizationCredentials = Depends(auth_scheme),
    db: AsyncSession = Depends(get_db),
):

    token = credentials.credentials  # Extract raw token

    try:
        payload = jwt.decode(
            token,
            settings.JWT_SECRET,
            algorithms=[settings.JWT_ALGORITHM]
        )
        user_id = int(payload.get("sub"))
    except:
        raise HTTPException(status_code=401, detail="Invalid token")

    result = await db.execute(
        select(models.User).filter(models.User.user_id == user_id)
    )
    user = result.scalars().first()

    if not user:
        raise HTTPException(status_code=401, detail="User not found")

    return user

# ======================================
# Reset Pass Utils
# ======================================
def generate_password_reset_token() -> tuple[str, str]:
    """Generate a raw token and its hash for password reset"""
    raw_token = str(uuid.uuid4())
    token_hash = hashlib.sha256(raw_token.encode("utf-8")).hexdigest()
    return raw_token, token_hash

def get_password_reset_expiry() -> datetime:
    """Get expiry time for password reset token"""
    return datetime.utcnow() + timedelta(minutes=settings.PASSWORD_RESET_TOKEN_EXPIRE_MINUTES)