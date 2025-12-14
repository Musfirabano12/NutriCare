from pydantic import BaseModel, EmailStr, validator
from typing import Optional, List
from datetime import datetime
from enum import Enum

# ======================================
# User Auth
# ======================================
class UserCreate(BaseModel):
    email: EmailStr
    password: str
    first_name: Optional[str] = None
    last_name: Optional[str] = None

class TokenResponse(BaseModel):
    access_token: str
    token_type: str = "bearer"
    refresh_token: Optional[str] = None
    expires_at: Optional[datetime] = None

class RefreshRequest(BaseModel):
    refresh_token: str

class LoginRequest(BaseModel):
    email: EmailStr
    password: str

# ======================================
# Reset Password
# ======================================
class ForgotPasswordRequest(BaseModel):
    email: EmailStr

class ResetPasswordRequest(BaseModel):
    token: str
    new_password: str

    @validator('new_password')
    def validate_password_length(cls, v):
        if len(v) < 8:
            raise ValueError('Password must be at least 8 characters long')
        return v

class ResetPasswordResponse(BaseModel):
    message: str
    success: bool

class PasswordResetTokenResponse(BaseModel):
    message: str
    token_sent: bool

# ======================================
# User Profile
# ======================================
class BloodSugarReading(BaseModel):
    reading_value: float
    reading_unit: str
    notes: Optional[str]

class DiabetesStatusEnum(str, Enum):
    none = "none"
    type1 = "type1"
    type2 = "type2"
    prediabetes = "prediabetes"
    gestational = "gestational"

class ActivityLevelEnum(str, Enum):
    sedentary = "sedentary"
    lightly_active = "lightly_active"
    moderately_active = "moderately_active"
    very_active = "very_active"
    extremely_active = "extremely_active"

class UserProfileRequest(BaseModel):
    user_id: int
    age: int
    gender: str
    weight_kg: float
    height_cm: float
    diabetes_status: DiabetesStatusEnum
    insulin_usage: bool
    insulin_dosage: Optional[float] = None
    activity_level: ActivityLevelEnum
    health_goals: List[int]
    dietary_preferences: List[int]
    blood_sugar: Optional[BloodSugarReading]  # <--- Add this


class UserProfileResponse(BaseModel):
    message: str
    profile_completed: bool = True

