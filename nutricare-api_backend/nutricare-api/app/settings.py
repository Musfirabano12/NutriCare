from pydantic import BaseSettings

class Settings(BaseSettings):
    # Database & Auth
    DATABASE_URL: str
    JWT_SECRET: str
    SQL_ECHO: bool = False
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60

    # Email Configuration
    SMTP_HOST: str = Field(..., env="SMTP_SERVER")
    SMTP_PORT: int
    SMTP_USER: str = Field(..., env="SMTP_USERNAME")
    SMTP_PASSWORD: str
    SMTP_FROM_EMAIL: str = Field(..., env="SENDER_EMAIL")
    FRONTEND_URL: str

    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"


settings = Settings()
