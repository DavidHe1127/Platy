#!/bin/bash

export PYTHONPATH=$PYTHONPATH:"$(pipenv --venv)/lib/python3.8/site-packages/"

python3 seed.py
