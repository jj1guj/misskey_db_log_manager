#!/bin/bash

COMPOSE_FILE="/home/jj1guj/misskey/compose.yml"  # compose.ymlのパス
SERVICE_NAME="db"  # compose.ymlで定義されているDBのサービス名
LOG_DIR="/var/lib/postgresql/data/log"
COMPRESS_DAYS=1
DELETE_DAYS=30

echo "$(date): Starting DB log management..."

# コンテナ内で圧縮コマンドを実行
echo "$(date): Compressing logs older than ${COMPRESS_DAYS} day(s)..."
docker compose -f $COMPOSE_FILE exec -T $SERVICE_NAME sh -c "find $LOG_DIR -name 'postgresql-*.log' -type f -mtime +${COMPRESS_DAYS} ! -name '*.gz' -exec gzip {} \;"

# コンテナ内で削除コマンドを実行
echo "$(date): Deleting compressed logs older than ${DELETE_DAYS} day(s)..."
docker compose -f $COMPOSE_FILE exec -T $SERVICE_NAME sh -c "find $LOG_DIR -name 'postgresql-*.log.gz' -type f -mtime +${DELETE_DAYS} -delete"

# ディスク使用量を確認
echo "$(date): Current log directory size:"
docker compose -f $COMPOSE_FILE exec -T $SERVICE_NAME sh -c "du -sh $LOG_DIR"

echo "$(date): Log management completed"
