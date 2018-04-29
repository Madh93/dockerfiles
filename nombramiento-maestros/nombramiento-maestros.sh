#! /bin/bash

TOKEN="" # Bot Token
PDF=""
SENT=0

while true; do

  PDF="$(docker run --rm -i nombramiento-maestros)"

  if [ "$SENT" -eq 0 ]; then
    if [ "$PDF" != "" ]; then
      curl -X POST "https://api.telegram.org/bot$TOKEN/sendDocument?chat_id=@nombramientos_maestros_tfe&document=$PDF"
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
