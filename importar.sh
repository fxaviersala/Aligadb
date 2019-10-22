#!/bin/bash
set -e

# Esperar SQLServer ...
sleep 30s

# Create tables
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "X1nGuXunG1" -Q "CREATE DATABASE BoIsModelExtress;"
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "X1nGuXunG1" -d BoIsModelExtress -i /import/migrate.sql -I

