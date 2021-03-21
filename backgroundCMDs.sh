#!/bin/bash
echo "WILLKOMMEN"
docker run --name my-postgres -e POSTGRES_PASSWORD=password -d postgres
docker exec -it my-postgres bash
psql -U postgres