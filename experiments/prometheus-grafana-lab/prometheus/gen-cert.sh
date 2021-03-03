#!/bin/bash

# openssl req \
#   -newkey rsa:2048 \
#   -days 365 \
#   -nodes \
#   -x509 \
#   -keyout nginx.key \
#   -out nginx.crt \
#   -subj "/C=AU/ST=Sydney/L=Sydney/O=DavidHe/CN=nginx"

# SAN cert
openssl req \
  -x509 \
  -newkey rsa:4096 \
  -sha256 \
  -days 365 \
  -nodes \
  -keyout nginx.key \
  -out nginx.crt \
  -extensions san \
  -config \
  <(echo "[req]";
    echo distinguished_name=req;
    echo "[san]";
    echo subjectAltName=DNS:nginx,DNS:federated-prom,IP:10.0.0.1
    ) \
  -subj "/CN=nginx"
