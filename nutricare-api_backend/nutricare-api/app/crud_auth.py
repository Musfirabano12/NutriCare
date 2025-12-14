import uuid
import hashlib
from sqlalchemy.future import select
from sqlalchemy.ext.asyncio import AsyncSession
from . import models
from .auth_utils import hash_password
from datetime import datetime
from sqlalchemy import delete
from app.config import settings


# ======================================
# User Auth CRUD
# ======================================
async def get_user_by_email(db: AsyncSession, email: str):
    q = await db.execute(select(models.User).filter(models.User.email == email))
    return q.scalars().first()

async def create_user(db: AsyncSession, email: str, first_name: str | None,
                      last_name: str | None, password: str):

    user = models.User(
        email=email,
        first_name=first_name,
        last_name=last_name,
        password_hash=hash_password(password)
    )

    db.add(user)

    try:
        await db.commit()
        await db.refresh(user)
        return user
    except Exception as e:
        await db.rollback()
        print("Create user error:", e)
        return None


async def create_refresh_token(db: AsyncSession, user_id: int, token_hash: str, expires_at: datetime):
    rt = models.RefreshToken(user_id=user_id, token_hash=token_hash, expires_at=expires_at)
    db.add(rt)
    await db.commit()
    await db.refresh(rt)
    return rt

async def get_refresh_token_by_hash(db: AsyncSession, token_hash: str):
    q = await db.execute(select(models.RefreshToken).filter(models.RefreshToken.token_hash == token_hash))
    return q.scalars().first()

async def revoke_refresh_token(db: AsyncSession, token_id):
    q = await db.execute(select(models.RefreshToken).filter(models.RefreshToken.token_id == token_id))
    token = q.scalars().first()
    if token:
        token.revoked = True
        token.revoked_at = datetime.utcnow()
        db.add(token)
        await db.commit()
        await db.refresh(token)
    return token

# ======================================
# Reset Pass CRUD
# ======================================
async def get_password_reset_token(db: AsyncSession, token_hash: str):
    """Find valid password reset token"""
    q = await db.execute(
        select(models.PasswordResetToken)
        .filter(models.PasswordResetToken.token_hash == token_hash)
        .filter(models.PasswordResetToken.used == False)
        .filter(models.PasswordResetToken.expires_at > datetime.utcnow())
    )
    return q.scalars().first()


async def create_password_reset_token(db: AsyncSession, user_id: int, token_hash: str, expires_at: datetime):
    """Create new password reset token"""
    # Create token
    token = models.PasswordResetToken(
        user_id=user_id,
        token_hash=token_hash,
        expires_at=expires_at,
        used=False
    )

    db.add(token)
    await db.commit()
    await db.refresh(token)
    return token


async def mark_password_reset_token_used(db: AsyncSession, token_id: uuid.UUID):
    """Mark token as used"""
    q = await db.execute(
        select(models.PasswordResetToken).filter(models.PasswordResetToken.token_id == token_id)
    )
    token = q.scalars().first()
    if token:
        token.used = True
        db.add(token)
        await db.commit()
    return token


async def update_user_password(db: AsyncSession, user_id: int, new_password_hash: str):
    """Update user's password"""
    q = await db.execute(select(models.User).filter(models.User.user_id == user_id))
    user = q.scalars().first()
    if user:
        user.password_hash = new_password_hash
        db.add(user)
        await db.commit()
        await db.refresh(user)
    return user