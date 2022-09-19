#!/bin/sh
set -ex

build=
for args in "$@"
do 
  if [ "$args" = "--build" ]; then
    build=1
  fi
done


unamestr=$(uname)
if [ "$unamestr" = 'Linux' ]; then
  export $(grep -v '^#' .env | xargs -d '\n')
elif [ "$unamestr" = 'FreeBSD' ] || [ "$unamestr" = 'Darwin' ]; then
  export $(grep -v '^#' .env | xargs -0)
fi


if [ "$build" == "1" ]; then
  docker-compose -f ./localnet/docker-compose-localnet.yml up --build
else
  docker-compose -f ./localnet/docker-compose-localnet.yml up
fi
