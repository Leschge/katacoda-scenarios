#!/bin/bash

echo "STARTE TUTORIAL ..." 
docker run --name my-postgres -e POSTGRES_PASSWORD=password -d postgres
sleep 1
docker exec -it my-postgres bash
sleep 1
psql -U postgres
sleep 1
\! clear