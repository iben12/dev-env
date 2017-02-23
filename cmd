#!/bin/bash

if [[ ! $APPLICATION_UID == $(id -u application) ]]
then
    usermod -u $APPLICATION_UID application
    groupmod -g $APPLICATION_GID application
fi

docker-compose run --rm $1 appcommand "${@:2}"