#!/bin/bash

openssl req \
  -newkey rsa:2048 \
  -days 365 \
  -nodes \
  -x509 \
  -keyout nginx.key \
  -out nginx.crt \
  -subj "/C=AU/ST=Sydney/L=Sydney/O=DavidHe/CN=nginx"
