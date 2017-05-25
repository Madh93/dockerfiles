#! /bin/bash

DESTINATION="" # Contact destination
HOME="" # Custom '/home/user' directory
PDF=""
SENT=0

while true; do

  PDF="$(docker run --rm -i nombramiento-maestros)"

  if [ "$SENT" -eq 0 ]; then
    if [ "$PDF" != "" ]; then
      docker run --rm -d -v $HOME/.telegram-cli:/root/.telegram-cli pataquets/telegram-cli -WR -e "msg $DESTINATION 'Mensaje enviado automáticamente\n\n $PDF'"
      echo "Nuevo PDF: $(date)" >> $HOME/.dockerfiles/nombramiento-maestros/oferta-maestros.log
      SENT=1
    fi
  fi

  if [ "$(date +'%H')" == "23" ]; then
    PDF=""
    SENT=0
    sleep 2h
  fi

  sleep 5m
done
