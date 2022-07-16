:: Accepts the proxy environment and application name as CLI arguments to process
:: $1- Folder $2 - ArangoDB Version
:: Eg. build 3.9.0

@echo off
echo Trying to build tag %2 ...
SET "DB_VERSION=%2"
docker compose --file %1/docker-compose.yml up --build