from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from app.models import UserProfile, SugarReading, HealthGoal, DietPreference
from app.schemas import UserProfileRequest  # Pydantic schema
from datetime import datetime

async def create_or_update_profile(db: AsyncSession, payload: UserProfileRequest):
    # Calculate BMI
    bmi = payload.weight_kg / ((payload.height_cm / 100) ** 2)

    # Upsert UserProfile
    profile = UserProfile(
        user_id=payload.user_id,
        gender=payload.gender,
        age=payload.age,
        weight_kg=payload.weight_kg,
        height_cm=payload.height_cm,
        bmi=bmi,
        diabetes_status=payload.diabetes_status,
        insulin_usage=payload.insulin_usage == "Yes, I use insulin",
        insulin_dosage=payload.insulin_dosage,
        activity_level=payload.activity_level,
        profile_completed=True
    )
    await db.merge(profile)

    # Add Blood Sugar Reading if present
    if payload.blood_sugar:
        sugar = SugarReading(
            user_id=payload.user_id,
            reading_value=payload.blood_sugar.reading_value,
            reading_unit=payload.blood_sugar.reading_unit,
            notes=payload.blood_sugar.notes,
            reading_time=datetime.utcnow()
        )
        db.add(sugar)

        # Health Goals
        for goal_id in payload.health_goals:
            result = await db.execute(select(HealthGoal).where(HealthGoal.goal_id == goal_id))
            g = result.scalar_one_or_none()
            if g:
                await db.execute(
                    "INSERT INTO user_health_goals (user_id, goal_id) VALUES (:u, :g) ON CONFLICT DO NOTHING",
                    {"u": payload.user_id, "g": g.goal_id}
                )

        # Dietary Preferences
        for diet_id in payload.dietary_preferences:
            result = await db.execute(select(DietPreference).where(DietPreference.diet_id == diet_id))
            p = result.scalar_one_or_none()
            if p:
                await db.execute(
                    "INSERT INTO user_diet_preferences (user_id, diet_id) VALUES (:u, :d) ON CONFLICT DO NOTHING",
                    {"u": payload.user_id, "d": p.diet_id}
                )

        await db.commit()
