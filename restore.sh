#!/bin/bash

# Carrega variáveis do .env  
source .env  

# Verifica se o arquivo de backup foi passado como argumento  
if [ -z "$1" ]; then  
    echo "Uso: ./restore.sh <arquivo_de_backup.sql.gz>"  
    exit 1  
fi  

BACKUP_FILE="$1"  

# Descompacta e restaura  
echo "[Celebi] Restaurando $PG_DATABASE para um estado anterior..."  
gunzip -c "$BACKUP_FILE" | psql -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" -d "$PG_DATABASE"  

echo "Banco de dados restaurado com sucesso!"  