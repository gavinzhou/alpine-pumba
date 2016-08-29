#!/sbin/dumb-init /bin/sh
set -e

if [ -S /var/run/docker.sock ]; then
  chown -R pumba:pumba /var/run/docker.sock
fi

exec gosu pumba:pumba "$@"

