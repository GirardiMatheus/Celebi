#!/bin/bash

# Carrega variáveis do .env  
source .env  

# Cria diretório de backups se não existir  
mkdir -p "$BACKUP_DIR"  

# Nome do arquivo com timestamp (ex: backup_20240326_142411.sql.gz)  
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")  
BACKUP_FILE="$BACKUP_DIR/backup_${PG_DATABASE}_${TIMESTAMP}.sql.gz"  

# Comando pg_dump + compressão  
echo "[Celebi] Criando backup de $PG_DATABASE..."  
pg_dump -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" -d "$PG_DATABASE" | gzip -${COMPRESS_LEVEL} > "$BACKUP_FILE"  

# Verifica se o backup foi criado  
if [ -f "$BACKUP_FILE" ]; then  
    echo "Backup salvo em: $BACKUP_FILE"  

    # Envia via SCP (se configurado)  
    if [ ! -z "$REMOTE_SERVER" ]; then  
        echo "Enviando backup para $REMOTE_SERVER..."  
        scp -i "$SCP_PRIVATE_KEY" "$BACKUP_FILE" "$REMOTE_SERVER"  
    fi  

    # Limpeza de backups antigos  
    echo "Removendo backups com mais de $RETENTION_DAYS dias..."  
    find "$BACKUP_DIR" -name "backup_${PG_DATABASE}_*.sql.gz" -mtime +$RETENTION_DAYS -delete  
else  
    echo "Falha no backup!"  
    exit 1  
fi 