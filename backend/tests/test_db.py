from sqlmodel import SQLModel, Session, create_engine, select
from backend.app.models import User
import datetime

def test_user_crud(tmp_path):
    db_file = tmp_path / "test.db"
    engine = create_engine(f"sqlite:///{db_file}", echo=False)
    SQLModel.metadata.create_all(engine)

    with Session(engine) as session:
        user = User()
        session.add(user)
        session.commit()
        session.refresh(user)
        assert user.id is not None
        assert isinstance(user.created_at, datetime.datetime)

    # read back
    with Session(engine) as session:
        users = session.exec(select(User)).all()
        assert len(users) == 1
