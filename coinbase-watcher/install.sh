#! /bin/bash

APP="coinbase-watcher"

docker build -t $APP .

cp $APP.sh /usr/local/bin/$APP
chmod +x /usr/local/bin/$APP

cp $APP.service /etc/systemd/system/$APP.service
cp $APP.timer /etc/systemd/system/$APP.timer

systemctl enable $APP.timer
systemctl start $APP.timer
