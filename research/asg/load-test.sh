#!/bin/sh

artillery quick -d 60 -r 10 -k http://0.0.0.0:8000/weather
# artillery quick -d 60 -r 10000 -k https://api.theparrodise.com/weather

