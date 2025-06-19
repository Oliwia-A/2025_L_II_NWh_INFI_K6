from flask import Flask

app = Flask(__name__)

from hello_world.views import register_routes  # noqa: E402

register_routes(app)
