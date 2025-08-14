#!/bin/bash
# Script para inicializar la base de datos externa (Postgres)

set -e

psql -h $DB_POSTGRESDB_HOST -p $DB_POSTGRESDB_PORT -U $DB_POSTGRESDB_USER <<EOF
CREATE DATABASE IF NOT EXISTS $DB_POSTGRESDB_DATABASE;
EOF