from sqlalchemy import Column, Integer, Numeric, Boolean, Text, Enum
from app.database import Base
import app.models.enums as enums

class UserProfile(Base):
    __tablename__ = "user_profiles"

    user_id = Column(Integer, primary_key=True)
    age = Column(Integer)
    gender = Column(Text)
    weight_kg = Column(Numeric)
    height_cm = Column(Numeric)
    bmi = Column(Numeric)
    activity_level = Column(enums.ActivityLevelEnum)
    diabetes_status = Column(enums.DiabetesStatusEnum)
    insulin_usage = Column(Boolean)
    insulin_dosage = Column(Numeric)
    profile_completed = Column(Boolean, default=True)
