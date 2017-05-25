#! /bin/bash

APP="tweefy"

docker build -t $APP .

cp $APP.service /etc/systemd/system/$APP.service
cp $APP.timer /etc/systemd/system/$APP.timer

systemctl enable $APP.timer
systemctl start $APP.timer
