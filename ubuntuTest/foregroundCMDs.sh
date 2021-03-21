#!/bin/bash

echo "STARTE TUTORIAL ..." 
#while [ ! -f /opt/.backgroundfinished ] ; do sleep 2; done;
docker run --name my-postgres -e POSTGRES_PASSWORD=password -d postgres
sleep 1
docker exec -it my-postgres bash
sleep 1
psql -U postgres
echo "FERTIG"