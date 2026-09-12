from logging.config import fileConfig
import os
import sys

from sqlalchemy import engine_from_config
from sqlalchemy import pool
from sqlmodel import SQLModel

from alembic import context

# this is the Alembic Config object, which provides
# access to the values within the .ini file in use.
config = context.config

# Interpret the config file for Python logging.
if config.config_file_name is not None:
    fileConfig(config.config_file_name)

# make backend package importable
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

# Import your models here
try:
    from backend.app.db.base import engine
    from backend.app.models import *  # noqa: F401
except Exception:
    # models or db may not be present yet; ignore import errors for now
    engine = None

# this is the metadata object for autogenerate support
target_metadata = SQLModel.metadata


def run_migrations_offline():
    url = config.get_main_option('sqlalchemy.url') or os.environ.get('DATABASE_URL')
    context.configure(url=url, target_metadata=target_metadata, literal_binds=True)
    with context.begin_transaction():
        context.run_migrations()


def run_migrations_online():
    connectable = engine
    if connectable is None:
        # attempt to create engine from config if backend.engine is unavailable
        db_url = config.get_main_option('sqlalchemy.url') or os.environ.get('DATABASE_URL')
        if db_url is None:
            raise RuntimeError('No database URL found for running migrations')
        from sqlmodel import create_engine
        connectable = create_engine(db_url, echo=False)

    with connectable.connect() as connection:
        context.configure(connection=connection, target_metadata=target_metadata)
        with context.begin_transaction():
            context.run_migrations()


if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()
