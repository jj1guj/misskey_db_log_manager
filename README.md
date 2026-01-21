# misskey_db_log_manager

一定期間経過したMisskeyのdbログを自動で削除するスクリプト

## 使い方

1. `COMPOSE_FILE`・`SERVICE_NAME`・`LOG_DIR`・`COMPRESS_DAYS`・`DELETE_DAYS`を書き換えて設定する
2. `./misskey_db_log_manager.sh`でスクリプトを実行
