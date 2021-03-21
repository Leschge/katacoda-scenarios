#!/bin/bash

echo "WILLKOMMEN"
docker run --name my-postgres -e POSTGRES_PASSWORD=password -d postgres
sleep 5
docker exec -it my-postgres bash
sleep 5
psql -U postgres