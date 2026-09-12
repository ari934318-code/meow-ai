import os
from typing import Iterator
from sqlmodel import SQLModel, create_engine, Session

# Use DATABASE_URL environment variable if provided; otherwise default to a local sqlite file for development
DATABASE_URL = os.getenv('DATABASE_URL', 'sqlite:///./dev.db')

# For SQLite, set check_same_thread to False to allow usage from different threads (useful in tests/runners)
connect_args = {"check_same_thread": False} if DATABASE_URL.startswith('sqlite') else {}

engine = create_engine(DATABASE_URL, echo=False, connect_args=connect_args)


def init_db():
    SQLModel.metadata.create_all(engine)


def get_session() -> Iterator[Session]:
    """Yield a SQLModel Session for FastAPI dependency injection.

    Usage:
        def endpoint(session: Session = Depends(get_session)):
            ...
    """
    with Session(engine) as session:
        yield session
