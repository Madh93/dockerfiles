#! /bin/bash

APP="rpi-transmission"
DIRECTORY="/home/pi/Torrent"

# Build image
docker build -t $APP .

# Create Torrents directory
if [ ! -d "$DIRECTORY" ]; then
    mkdir $DIRECTORY
    chgrp users $DIRECTORY
    chmod g+s $DIRECTORY
    mkdir -p $DIRECTORY/completed $DIRECTORY/incomplete
fi

# Run container
docker run -d --restart=always --name $APP  \
  -v /etc/localtime:/etc/localtime:ro \
  -v $DIRECTORY/completed:/app/completed \
  -v $DIRECTORY/incomplete:/app/incomplete \
  -p 9091:9091 \
  -p 51413:51413/udp \
  -p 51413:51413/tcp \
  $APP
