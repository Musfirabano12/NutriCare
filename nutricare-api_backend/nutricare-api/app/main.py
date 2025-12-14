from fastapi import FastAPI
from contextlib import asynccontextmanager
from app.database import engine
from app.routers import auth, pass_reset
from fastapi.middleware.cors import CORSMiddleware
from app.routers import profile
from app.models import Base

@asynccontextmanager
async def lifespan(app: FastAPI):
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    yield  # shutdown logic if any

app = FastAPI(title="NutriCare Auth", lifespan=lifespan)

@app.get("/")
async def root():
    return {"message": "Welcome to NutriCare API"}

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
app.include_router(auth.router)
app.include_router(profile.router)
app.include_router(pass_reset.router)

origins = [
    "*",  # allow all - for development
]