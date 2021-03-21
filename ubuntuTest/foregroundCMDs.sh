#!/bin/bash

echo "Waiting to complete"; while [ ! -f /opt/.backgroundfinished ] ; do sleep 2; done;
docker exec -it my-postgres bash
psql -U postgres
echo "done"