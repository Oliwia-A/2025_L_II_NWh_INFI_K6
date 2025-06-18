from flask import request, jsonify
from hello_world import app
from hello_world.formater import get_formatted, SUPPORTED, PLAIN

moje_imie = "Oliwia"
msg = "Hello World!"


@app.route('/')
def index():
    output = request.args.get('output') or PLAIN
    formatted = get_formatted(msg, moje_imie, output.lower())

    if output.lower() == 'json':
        return jsonify({"message": formatted})
    else:
        return formatted


@app.route('/outputs')
def supported_output():
    return ", ".join(SUPPORTED)
