#!/bin/sh
build=
for args in "$@"
do 
  if [ "$args" = "--build" ]; then
    build=1
  fi
done

ENV_FILE=.env
if [ ! -f "$ENV_FILE" ]; then
  echo "$ENV_FILE file doesn't exist"
  echo "Run:         cp example.env .env"
  echo "modify variables in .env, and run this script again."
  exit 0
fi


unamestr=$(uname)
if [ "$unamestr" = 'Linux' ]; then
  export $(grep -v '^#' .env | xargs -d '\n')
elif [ "$unamestr" = 'FreeBSD' ] || [ "$unamestr" = 'Darwin' ]; then
  export $(grep -v '^#' .env | xargs -0)
fi


if [ "$build" == "1" ]; then
  docker-compose -f ./localnet/docker-compose-localnet.yml up --build -d
else
  docker-compose -f ./localnet/docker-compose-localnet.yml up -d
fi
