#!/bin/bash

openssl req \
  -newkey rsa:2048 \
  -days 365 \
  -nodes \
  -x509 \
  -keyout federated-prom.key \
  -out federated-prom.crt \
  -subj "/C=AU/ST=Sydney/L=Sydney/O=DavidHe/CN=federated-prom"
