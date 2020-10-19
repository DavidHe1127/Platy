from flask import Flask, jsonify, request
from random import randrange
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
metrics = PrometheusMetrics(app)

people = [{
    "name":
    "Pet sametry",
    'casts': ['Tim Robbins', 'Morgan Freeman', 'Bob Gunton', 'William Sadler'],
    'genres': ['Drama']
}, {
    'name': 'The Godfather',
    'casts': ['Marlon Brando', 'Al Pacino', 'James Caan', 'Diane Keaton'],
    'genres': ['Crime', 'Drama']
}]


@app.route('/')
def hello():
    return {'hello': 'world'}


@app.route('/movies')
@metrics.counter('call_counter',
                 'Count response type',
                 labels={
                     'path': lambda: request.path,
                     'status': lambda resp: resp.status_code
                 })
def movies():
    num = randrange(20)

    if num < 4:
        return {'message': 'FORBIDDEN'}, 403
    elif num < 8:
        return {'message': 'NOT FOUND'}, 404
    else:
        return jsonify(people), 200


if __name__ == '__main__':
    app.run(port=3100, host='0.0.0.0')
