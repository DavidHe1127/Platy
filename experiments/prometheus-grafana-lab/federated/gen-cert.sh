#!/bin/bash

# openssl req \
#   -newkey rsa:2048 \
#   -days 365 \
#   -nodes \
#   -x509 \
#   -keyout federated-prom.key \
#   -out federated-prom.crt \
#   -subj "/C=AU/ST=Sydney/L=Sydney/O=DavidHe/CN=federated-prom"

# SAN cert
openssl req \
  -x509 \
  -newkey rsa:4096 \
  -sha256 \
  -days 365 \
  -nodes \
  -keyout federated-prom.key \
  -out federated-prom.crt \
  -extensions san \
  -config \
  <(echo "[req]";
    echo distinguished_name=req;
    echo "[san]";
    echo subjectAltName=DNS:federated-prom,DNS:nginx,IP:10.0.0.1
    ) \
  -subj "/CN=federated-prom"
