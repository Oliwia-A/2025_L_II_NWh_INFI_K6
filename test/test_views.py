import unittest
import json
from hello_world import app
from hello_world.formater import SUPPORTED


class FlaskrTestCase(unittest.TestCase):
    def setUp(self):
        app.config['TESTING'] = True
        self.app = app.test_client()

    def test_outputs(self):
        rv = self.app.get('/outputs')
        s = rv.data.decode()
        outputs = s.replace('\n', '').split(',')
        outputs = [o.strip() for o in outputs]
        self.assertEqual(set(outputs), set(SUPPORTED))

    def test_msg_with_output(self):
        rv = self.app.get('/?output=json')
        data = json.loads(rv.data.decode())
        self.assertEqual(data, { "imie": "Oliwia", "msg": "Hello World!" })