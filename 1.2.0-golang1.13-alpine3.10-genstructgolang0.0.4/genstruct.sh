#!/bin/sh

if [ ! -z "$1" ]
then
    genstructgraphql -schema="$1"
fi