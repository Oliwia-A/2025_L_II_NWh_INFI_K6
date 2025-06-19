import json
from hello_world import app
from hello_world.formater import SUPPORTED


def test_outputs():
    client = app.test_client()
    response = client.get('/outputs')
    assert response.status_code == 200

    text = response.data.decode()
    outputs = [o.strip() for o in text.split(',')]
    assert set(outputs) == set(SUPPORTED)


def test_msg_with_output():
    client = app.test_client()
    response = client.get('/?output=json')
    assert response.status_code == 200

    data = json.loads(response.data.decode())
    assert data == {
        "imie": "Oliwia",
        "msg": "Hello World!"
    }
