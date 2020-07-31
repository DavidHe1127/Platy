const restify = require('restify');
const restifyClient = require('restify-clients');
const osu = require('node-os-utils');

const cpu = osu.cpu;

const PORT = process.env.PORT || 8000;
const HOST = process.env.HOST || '0.0.0.0';

const query = 'schofields';
const key = process.env.ECS_WEATHER_API_KEY;

const server = restify.createServer();
const weatherClient = restifyClient.createJsonClient({
  url: process.env.ECS_WEATHER_API_URL,
});

server.get('/weather', (req, res, next) => {
  weatherClient.get(
    `/v1/current.json?key=${key}&q=${query}`,
    (err, req, r, obj) => {
      cpu.usage().then((cpuPercentage) => {
        res.send(obj);
        next();
      });
    }
  );
});

// b/g deployment
// server.get('/weather', (req, res, next) => {
//   res.send('green');
//   next();
// });

server.get('/health_check', (req, res, next) => {
  res.send({
    healthy: true,
  });
  next();
});

server.listen(PORT, HOST, () => {
  console.log('%s listening at %s', server.name, server.url);
});

function fibo(n) {
  return n > 1 ? fibo(n - 1) + fibo(n - 2) : 1;
}
