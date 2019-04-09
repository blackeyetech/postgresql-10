This repo will allow you to create a postgres 10 image with SSL enabled.

SSL certs automatically built each time a container is created.

You will need to map and expose port ***5432*** to the port you wish to use as your
DB server port.

You will also need to mount a volume or bind mount a directory containing the 
database files you wish to use to this directory: 

***/var/lib/postgresql/data***.

This image is based on the official Docker Image for postgres. Please see its
description for details on initialising your DB if you are creating a new
one.

