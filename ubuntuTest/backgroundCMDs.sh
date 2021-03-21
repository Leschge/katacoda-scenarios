#!/bin/bash

echo "WILLKOMMEN"
docker run --name my-postgres -e POSTGRES_PASSWORD=password -d postgres
echo "done" >> /opt/.backgroundfinished