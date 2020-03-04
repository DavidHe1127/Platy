'use strict';

const express = require('express');

// Constants
const PORT = 8000;
const HOST = '0.0.0.0';

// App
const app = express();

app.use(function(req, res, next) {
  var fullUrl = req.protocol + '://' + req.get('host') + req.originalUrl;
  console.log('request url:', fullUrl);
  next();
});

app.get('/health_check', (req, res) => {
  console.log('Oh yeah im feeling awesome!!!');

  let proxyServer = '';

  if (req.headers['x-nginx']) {
    proxyServer = req.headers['x-nginx'];
  }

  res.status(200).json({
    msg: 'Oh yeah im feeling awesome!!!',
    agent: req.headers['user-agent'],
    proxyServer
  });

  console.log(req.headers);
});

app.get('/greetings', (req, res) => {
  res.status(200).json({
    msg: `Merry xmas!!! From ${process.env.INSTANCE_ID}
          It's updated ${process.env.TEST_UPDATE}
          `
  });
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
