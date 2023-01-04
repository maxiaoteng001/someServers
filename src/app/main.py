from fastapi import FastAPI

from app.database import Base, engine
from app.tools.router import router as tools_router

Base.metadata.create_all(engine)

app = FastAPI()

app.include_router(tools_router, prefix="/tools", tags=["Tools"])
