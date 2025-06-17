from flask import request
from hello_world import app
from hello_world.formater import get_formatted, SUPPORTED, PLAIN

moje_imie = "Oliwia"
msg = "Hello World!"


@app.route('/')
def index():
    output = request.args.get('output')
    if not output:
        output = PLAIN
    return get_formatted(msg, moje_imie, output.lower())


@app.route('/outputs')
def supported_output():
    return ", ".join(SUPPORTED)
