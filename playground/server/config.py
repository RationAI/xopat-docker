import os
from pathlib import Path

from dotenv import load_dotenv

base_dir = Path(__file__).parent.absolute()
load_dotenv(base_dir / ".flaskenv")

class Config:
    #SECRET_KEY = os.environ.get("SECRET_KEY")
    #STATIC_FOLDER = base_dir / "rationai" / "histoviso_explain" / "static"
    TEMPLATES_FOLDER = base_dir / "rationai" / "histoviso_explain" / "templates"

class ProdConfig(Config):
    FLASK_ENV = "production"
    ENV = "production"
    DEBUG = False
    TESTING = False

class DevConfig(Config):
    FLASK_ENV = "development"
    ENV = "development"
    DEBUG = True
    TESTING = True
