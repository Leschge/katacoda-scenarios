#!/bin/bash

echo "STARTE TUTORIAL ..." 
docker run --name my-postgres -e POSTGRES_PASSWORD=password -d postgres
sleep 1
docker exec -it my-postgres bash
sleep 2
psql -U postgres
\! clear

#docker copy /usr/local/bin/data.json my-postgres:/data.json