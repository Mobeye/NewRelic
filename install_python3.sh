#!/bin/bash

if ( ! which python3 >/dev/null ); then
  brew install python3
fi
python3 -m venv ./venv
source "./venv/bin/activate"
pip install --upgrade pip
pip install -r requirements.txt

cd Mobeye_NewRelic

export NEW_RELIC_CONFIG_FILE=`pwd`/newrelic.ini
export NEW_RELIC_STARTUP_DEBUG=True

newrelic-admin run-program ../venv/bin/uwsgi --ini uwsgi.ini
