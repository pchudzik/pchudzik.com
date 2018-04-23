#!/bin/sh

set -e

if [ -f credentials.sh ]; then
	. ./credentials.sh
fi

docker run \
	--rm -it \
	-e FTP_USER=${FTP_LOGIN} \
	-e FTP_PASSWORD=${FTP_PASSWORD} \
	-v "$(pwd):/site" \
	hugo-site deploy
