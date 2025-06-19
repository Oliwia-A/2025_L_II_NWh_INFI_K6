from flask import request, jsonify
from hello_world.formater import get_formatted, SUPPORTED, PLAIN

moje_imie = "Oliwia"
msg = "Hello World!"


def register_routes(app):
    @app.route('/')
    def index():
        output = request.args.get('output') or PLAIN
        formatted = get_formatted(msg, moje_imie, output.lower())

        if output.lower() == 'json':
            return jsonify({"imie": moje_imie, "msg": msg})
        return formatted


    @app.route('/outputs')
    def supported_output():
        return ", ".join(SUPPORTED)
