#!/bin/bash

deploy() {
  # Fetching data
  mkdir -p database/data || return
  cd database/data || return
  if [ ! -e "database/data" ] || [ -z "$(ls -A database/data)" ]; then
    wget -O archive.zip https://useful-datasets-269012942764.s3.amazonaws.com/archive.zip
    unzip archive.zip && rm archive.zip
  else
    echo '/database/data folder is not empty. Skipping download'
  fi

  # Deploying databases
  docker-compose up -d
  cd ..

}

exit() {
  cd database || return
  docker-compose down

}

case $1 in
  deploy)
    deploy
    ;;
  exit)
    exit
    ;;
  *)
    echo 'Invalid argument! Usage: $0 {deploy | exit}'
    ;;
esac