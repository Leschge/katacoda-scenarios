#!/bin/bash

echo "STARTE TUTORIAL ..." 
while [ ! -f /opt/.backgroundfinished ] ; do sleep 2; done;
docker exec -it my-postgres bash
sleep 2
psql -U postgres
echo "FERTIG"