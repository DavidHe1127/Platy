const restify = require('restify');
const restifyClient = require('restify-clients');

const PORT = process.env.PORT || 8000;
const HOST = process.env.HOST || '0.0.0.0';

const query = 'schofields';
const key = 'b49d801e628045cf87c51838202003'

const server = restify.createServer();
const weatherClient = restifyClient.createJsonClient({
  url: 'https://api.weatherapi.com'
});

server.get('/weather', (req, res, next) => {
  weatherClient.get(`/v1/current.json?key=${key}&q=${query}`, (err, req, r, obj) => {
    res.send(obj);
    next();
  });
});

server.listen(PORT, HOST, () => {
  console.log('%s listening at %s', server.name, server.url);
});

