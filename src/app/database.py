import re
from typing import Any

from sqlalchemy import create_engine
from sqlalchemy.ext.compiler import compiles
from sqlalchemy.ext.declarative import declarative_base, declared_attr
from sqlalchemy.orm import sessionmaker
from sqlalchemy.schema import CreateColumn

from app.config import SQLALCHEMY_DATABASE_URI


def resolve_table_name(name):
    names = re.split(r"(?=[A-Z])", name)
    return "_".join([x.lower() for x in names if x])


@compiles(CreateColumn, "postgresql")
def use_identity(element: Any, compiler: Any, **kw: dict) -> str:
    text = compiler.visit_create_column(element, **kw)
    return text.replace("SERIAL", "INT GENERATED BY DEFAULT AS IDENTITY")


class CustomBase:
    @declared_attr
    def __tablename__(self) -> str:
        return resolve_table_name(self.__name__)


Base = declarative_base(cls=CustomBase)

engine = create_engine(SQLALCHEMY_DATABASE_URI)
SessionLocal = sessionmaker(bind=engine)


def get_db():
    try:
        db = SessionLocal()
        yield db
    finally:
        db.close()