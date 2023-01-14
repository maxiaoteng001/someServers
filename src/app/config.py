from starlette.config import Config

config = Config(".env")

JWT_EXP: int = 60 * 24 * 93  # 93 days while debug
JWT_ALG: str = config("ALGORITHM", default="HS256")
JWT_SECRET: str = config("SECRET_KEY", default="zbrwRkYaGpWNYac3")

SQLALCHEMY_DATABASE_URI = config("DATABASE_URL", default="mysql://root@localhost/spiders")
