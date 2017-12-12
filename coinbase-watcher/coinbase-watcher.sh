#! /bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root" 2>&1
  exit 1
fi

APP="coinbase-watcher"
MY_USER="ubuntu"
DIRECTORY="/home/$MY_USER/.dockerfiles/$APP/db"

if [ -n "$(docker ps -a -q --filter name=$APP)" ]; then
  docker start -i $APP
else
  docker run -i --name $APP -v $DIRECTORY:/app/db $APP start.rb
fi
