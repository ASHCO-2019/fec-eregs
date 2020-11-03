#!/bin/bash

rand_mod=$(expr $RANDOM % 5)
if [ $rand_mod -eq 0 ]; then
    echo "Starting divisible by five app"
else
    echo "Crashing non-divisible by five app";
    exit 1
fi
# Set environment options to exit immediately if a non-zero status code
# appears from a command or within a pipe
echo "JL test"
set -o errexit
set -o pipefail

python manage.py migrate --fake-initial
gunicorn -k gevent -w 2 --bind=0.0.0.0:$PORT fec_eregs.wsgi:application
