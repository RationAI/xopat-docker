FROM python:3.7.2-slim
COPY ./requirements.txt /
RUN apt update \
    && apt install -y nano libtiff5-dev libjpeg62-turbo-dev libopenjp2-7-dev zlib1g-dev \
    libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python3-tk \
    libharfbuzz-dev libfribidi-dev libxcb1-dev
RUN pip3 install -r /requirements.txt
COPY . /
WORKDIR /
EXPOSE 5000
ENTRYPOINT ["./server/entrypoint.sh"]

