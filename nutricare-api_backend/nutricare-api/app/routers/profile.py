from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.database import get_db
from app.crud_profile import create_or_update_profile
from app.schemas import UserProfileRequest, UserProfileResponse

router = APIRouter(prefix="/profile", tags=["Profile"])

@router.post("/create", response_model=UserProfileResponse)
async def create_profile(payload: UserProfileRequest, db: AsyncSession = Depends(get_db)):
    await create_or_update_profile(db, payload)
    return {
        "success": True,
        "message": "Profile created successfully"
    }
