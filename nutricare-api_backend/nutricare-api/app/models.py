from datetime import datetime
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import declarative_base, relationship
from sqlalchemy import Column, Integer, Text, Boolean, TIMESTAMP, func, ForeignKey, DateTime, Enum, Numeric
from sqlalchemy.dialects.postgresql import UUID
import uuid
from enum import Enum as PyEnum

from app.schemas import ActivityLevelEnum, DiabetesStatusEnum

Base = declarative_base()

# ENUMs
activity_level = Column(
    Enum(ActivityLevelEnum, name="activity_level_enum", create_type=False),
    nullable=False
)

diabetes_status = Column(
    Enum(DiabetesStatusEnum, name="diabetes_status_enum", create_type=False),
    nullable=False
)

# ======================================
# Users
# ======================================
class User(Base):
    __tablename__ = "users"

    user_id = Column(Integer, primary_key=True, index=True)
    first_name = Column(Text)
    last_name = Column(Text)
    email = Column(Text, unique=True, nullable=False, index=True)
    password_hash = Column(Text, nullable=False)
    is_active = Column(Boolean, default=True)
    created_at = Column(TIMESTAMP(timezone=True), server_default=func.now())
    updated_at = Column(TIMESTAMP(timezone=True), server_default=func.now(), onupdate=func.now())
    refresh_tokens = relationship("RefreshToken", back_populates="user", cascade="all, delete-orphan")
    password_reset_tokens = relationship("PasswordResetToken", back_populates="user", cascade="all, delete-orphan")

# ======================================
# Refresh Tokens
# ======================================
class RefreshToken(Base):
    __tablename__ = "refresh_tokens"

    token_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(Integer, ForeignKey("users.user_id", ondelete="CASCADE"), nullable=False)
    token_hash = Column(Text, nullable=False)
    issued_at = Column(TIMESTAMP(timezone=True), server_default=func.now())
    expires_at = Column(TIMESTAMP(timezone=True), nullable=False)
    revoked = Column(Boolean, default=False)
    revoked_at = Column(TIMESTAMP(timezone=True), nullable=True)
    user = relationship("User", back_populates="refresh_tokens")


# ======================================
# Reset Password
# ======================================

class PasswordResetToken(Base):
    __tablename__ = "password_reset_tokens"

    token_id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(Integer, ForeignKey("users.user_id", ondelete="CASCADE"), nullable=False)
    token_hash = Column(Text, nullable=False)
    issued_at = Column(TIMESTAMP(timezone=True), server_default=func.now())
    expires_at = Column(TIMESTAMP(timezone=True), nullable=False)
    used = Column(Boolean, default=False)

    # Relationship
    user = relationship("User", back_populates="password_reset_tokens")


# ======================================
# User Profile
# ======================================
class UserProfile(Base):
    __tablename__ = "user_profiles"

    user_id = Column(Integer, ForeignKey("users.user_id"), primary_key=True)
    age = Column(Integer)
    gender = Column(Text)
    weight_kg = Column(Numeric)
    height_cm = Column(Numeric)
    bmi = Column(Numeric)
    activity_level = Column(Enum(ActivityLevelEnum, name="activity_level_enum"), nullable=False)
    diabetes_status = Column(Enum(DiabetesStatusEnum, name="diabetes_status_enum"), nullable=False)
    insulin_usage = Column(Boolean, default=False)
    insulin_dosage = Column(Numeric, nullable=True)
    profile_completed = Column(Boolean, default=False)
    created_at = Column(TIMESTAMP(timezone=True), server_default=func.now())
    updated_at = Column(TIMESTAMP(timezone=True), server_default=func.now(), onupdate=func.now())

    #Relationships
    blood_sugar_readings = relationship("SugarReading", back_populates="user_profile", cascade="all, delete-orphan")
    health_goals = relationship(
        "UserHealthGoals",
        primaryjoin="UserProfile.user_id == UserHealthGoals.user_id",
        back_populates="user_profile",
        cascade="all, delete-orphan"
    )
    dietary_preferences = relationship(
        "UserDietPreferences",
        primaryjoin="UserProfile.user_id == UserDietPreferences.user_id",
        back_populates="user_profile",
        cascade="all, delete-orphan"
    )

# ======================================
# Health Goals
# ======================================
class HealthGoal(Base):
    __tablename__ = "health_goals"
    goal_id = Column(Integer, primary_key=True)
    goal_name = Column(String)

class UserHealthGoals(Base):
    __tablename__ = "user_health_goals"
    user_id = Column(Integer, ForeignKey("user_profiles.user_id"), primary_key=True)
    goal_id = Column(Integer, ForeignKey("health_goals.goal_id"), primary_key=True)

    user_profile = relationship(
        "UserProfile",
        primaryjoin="UserHealthGoals.user_id == UserProfile.user_id",
        back_populates="health_goals")

# ======================================
# Diet Preferences
# ======================================
class DietPreference(Base):
    __tablename__ = "dietary_preferences"
    diet_id = Column(Integer, primary_key=True)
    diet_name = Column(String)

class UserDietPreferences(Base):
    __tablename__ = "user_diet_preferences"
    user_id = Column(Integer, ForeignKey("user_profiles.user_id"), primary_key=True)
    diet_id = Column(Integer, ForeignKey("dietary_preferences.diet_id"), primary_key=True)

    user_profile = relationship(
        "UserProfile",
        primaryjoin="UserDietPreferences.user_id == UserProfile.user_id",
        back_populates="dietary_preferences"
    )
# ======================================
# Blood Sugar Readings
# ======================================
class SugarReading(Base):
    __tablename__ = "sugar_readings"

    reading_id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("user_profiles.user_id", ondelete="CASCADE"), nullable=False)
    reading_value = Column(Numeric, nullable=False)
    reading_unit = Column(Text, nullable=False)
    notes = Column(Text, nullable=True)
    reading_time = Column(DateTime(timezone=True), nullable=False, server_default=func.now())

    # Relationship
    user_profile = relationship("UserProfile", back_populates="blood_sugar_readings")