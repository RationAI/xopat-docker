#This file is only a development entrypoint
#in case you want to run with python: python app.py
#in realcase scenario, we run the server using gunicorn
from server import init_app

app = init_app("Dev")

if __name__ == "__main__":
    app.run(port=5000)
