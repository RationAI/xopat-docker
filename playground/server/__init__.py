import os
import locale
from flask import Flask

MODE = "Prod"

os.environ["PYTHONIOENCODING"] = "utf-8"
os.environ["TF_CPP_MIN_LOG_LEVEL"] = "1"

def init_app(mode: str = "Prod"):
    """Create a Flask app.

    Parameters
    ----------
    mode
        Mode of the server configuraiton. ["Dev" or "Prod"], by default "Prod"

    Returns
    -------
    Flask app
    """
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_object(f"server.config.{mode}Config")

    with app.app_context():
        from server import routes

        app.register_blueprint(routes.bp)

        return app
