#!/bin/bash

echo "STARTE TUTORIAL ..." 
docker run --name my-postgres -e POSTGRES_PASSWORD=password -d postgres
sleep 1
docker cp /root/json/data.json my-postgres:/json/data.json
docker exec -it my-postgres bash
sleep 2
psql -U postgres
\! clear
