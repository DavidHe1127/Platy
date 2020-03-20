const restify = require('restify');
const restifyClient = require('restify-clients');

const PORT = process.env.PORT || 8000;
const HOST = process.env.HOST || '0.0.0.0';

const query = 'san';

const server = restify.createServer();
const weatherClient = restifyClient.createJsonClient({
  url: 'https://www.metaweather.com'
});

server.get('/weather', (req, res, next) => {
  weatherClient.get(`/api/location/search/?query=${query}`, (err, req, res, obj) => {
    console.log('xxx', err);

    res.send('hello ' + req.params.name);
    next();
  });
});

server.listen(PORT, HOST, () => {
  console.log('%s listening at %s', server.name, server.url);
});

