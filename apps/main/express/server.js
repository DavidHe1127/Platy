'use strict';

const express = require('express');

// HOST - A domain name or IP address of the server to issue the request to
// when settting it to 0.0.0.0, it means listen on all interfaces
// think of interfaces as ethernet ports. So 0.0.0.0 will make node server to handle all requests
// being sent to the HOST machine where node server is no matter through which ethernet port
const PORT = process.env.PORT || 8000;
const HOST = process.env.HOST || '0.0.0.0';

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
    msg: `Hello req served by instance ${process.env.INSTANCE_ID} \n

          My next goal is ${process.env.NEXT_GOAL}`
  });
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
