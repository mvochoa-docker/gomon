#!/bin/sh

set -e

DIRECTORY=/etc/ssl/ca-certificates


if [ ! -d "$DIRECTORY" ]; then
    mkdir $DIRECTORY
    if [ ! -d "/usr/local/share/ca-certificates" ]; then
        cp -R /usr/local/share/ca-certificates/* $DIRECTORY/

        for ext in crt cer pem; do
            if [ -f $DIRECTORY/*.$ext ]; then
                cat $DIRECTORY/*.$ext >> /etc/ssl/certs/ca-certificates.crt
            fi
        done
    fi
fi

gomon -build="true" \
      -command="genstruct \$FILE" \
      -pattern="(.+\.graphql)$" &

exec "$@"