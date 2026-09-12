import os
from sqlmodel import SQLModel, create_engine

# Use DATABASE_URL environment variable if provided; otherwise default to a local sqlite file for development
DATABASE_URL = os.getenv('DATABASE_URL', 'sqlite:///./dev.db')

# For SQLite, set check_same_thread to False to allow usage from different threads (useful in tests/runners)
connect_args = {"check_same_thread": False} if DATABASE_URL.startswith('sqlite') else {}

engine = create_engine(DATABASE_URL, echo=False, connect_args=connect_args)


def init_db():
    SQLModel.metadata.create_all(engine)
