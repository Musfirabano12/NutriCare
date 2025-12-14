from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
    DATABASE_URL: str
    SQL_ECHO: bool = False
    JWT_SECRET: str
    JWT_ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8"
    )

    SMTP_HOST: str = "smtp.gmail.com"
    SMTP_PORT: int = 587
    SMTP_USER: str = "nutricareai4@gmail.com"
    SMTP_PASSWORD: str = "zntuqfsjjslhlzlx"
    SMTP_FROM_EMAIL: str = "nutricareai4@gmail.com"
    FRONTEND_URL: str = "http://localhost:8000"
    PASSWORD_RESET_TOKEN_EXPIRE_MINUTES: int = 60

    model_config = {
        "env_file": ".env",
        "env_file_encoding": "utf-8"
    }

settings = Settings()
