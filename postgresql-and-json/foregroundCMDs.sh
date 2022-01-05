#!/bin/bash

echo "STARTE TUTORIAL ..." 
docker run --name my-postgres -e POSTGRES_PASSWORD=password -d postgres
sleep 10
mkdir /root/json
docker cp /root/json/data.json my-postgres:/json/data.json
docker cp /root/json/data.json my-postgres:/data.json
docker exec -it my-postgres bash
sleep 3
psql -U postgres
\! clear
