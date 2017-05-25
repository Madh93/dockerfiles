#! /bin/bash

APP="nombramiento-maestros"

docker build -t $APP .

cp $APP.sh /usr/local/bin/$APP
chmod +x /usr/local/bin/$APP

cp $APP.service /etc/systemd/system/$APP.service

systemctl enable $APP.service
systemctl start $APP.service
