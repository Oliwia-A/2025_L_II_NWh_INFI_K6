FROM python:3

ARG APP_DIR=/usr/src/hello_world_printer

WORKDIR /tmp
ADD requirements.txt /tmp/requirements.txt
ADD test_requirements.txt /tmp/test_requirements.txt
RUN pip install -r /tmp/requirements.txt && pip install -r /tmp/test_requirements.txt

RUN mkdir -p $APP_DIR
ADD hello_world/ $APP_DIR/hello_world/
ADD test/ $APP_DIR/test/
ADD main.py Makefile $APP_DIR

WORKDIR $APP_DIR

CMD PYTHONPATH=$PYTHONPATH:/usr/src/hello_world_printer \
    FLASK_APP=hello_world flask run --host=0.0.0.0