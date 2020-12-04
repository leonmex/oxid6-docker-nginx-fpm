#!/usr/bin/env bash
set -e

DIR=/entrypoint.d
if [[ -d "$DIR" ]]
then
	/bin/run-parts --verbose --regex '\.sh$' "$DIR"
fi

# Start the php-fpm service
/usr/local/sbin/php-fpm

exec "$@"