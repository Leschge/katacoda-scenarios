#!/bin/bash

echo "WILLKOMMEN"
docker run --name my-postgres -e POSTGRES_PASSWORD=password -d postgres
#echo "done" >> /opt/.backgroundfinished
sleep 3
echo "DOCKER EXEC"
docker exec -it my-postgres bash
sleep 1
echo "PSQL"
psql -U postgres
echo "FERTIG"