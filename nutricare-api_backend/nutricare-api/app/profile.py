from pydantic import BaseModel
from typing import List, Optional

class ProfileCreateRequest(BaseModel):
    user_id: int
    gender: str
    age: int
    weight_kg: float
    height_cm: float
    diabetes_status: str
    insulin_usage: bool
    insulin_dosage: Optional[float] = None
    blood_sugar: Optional[BloodSugarReading]
    activity_level: str
    health_goals: List[int]
    dietary_preferences: List[int]

class ProfileCreateResponse(BaseModel):
    success: bool
    message: str
