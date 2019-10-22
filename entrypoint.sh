#!/bin/bash
set -e

/opt/mssql/bin/sqlservr & /import/importar.sh && while true; do sleep 1; done
