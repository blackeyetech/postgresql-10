#!/bin/bash

# Check if postgres command line args have been passed in
if [ "${1:0:1}" = '-' ]; then
  # If so then add postgres in front
  set -- postgres "$@"
fi

# Can't start postgres as root so chek for that
if [ "$1" = 'postgres' ] && [ "$(id -u)" = '0' ]
then
  # OK, we have to change to user and re-run this script
  echo "gosu postgres ..."
  exec gosu postgres "$BASH_SOURCE" "$@"
fi

# Check if we are running postgres or another command
if [ "$1" = 'postgres' ]
then
  # We need to copy the pre-configured configs 
  cd /var/lib/postgresql/data

  cp /data-configs/* .

  # We need to create SSL cert and key
  openssl req -new -x509 -days 365 -nodes -text -out server.crt \
    -keyout server.key -subj "/CN=db"

  chmod og-rwx server.key
  chown postgres server.key server.crt
fi

# Now run whatever the user requested (normally it is postgres)
exec $@
