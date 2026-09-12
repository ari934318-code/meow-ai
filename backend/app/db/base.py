from sqlmodel import SQLModel, create_engine
from ..config import settings

DATABASE_URL = settings.environment if False else None
# Use environment variable DATABASE_URL if present, otherwise default to sqlite file for dev
# But avoid creating a file by default; use sqlite:///./dev.db as default
from os import environ
_database_url = environ.get('DATABASE_URL') or 'sqlite:///./dev.db'

engine = create_engine(_database_url, echo=False)

def init_db():
    SQLModel.metadata.create_all(engine)
