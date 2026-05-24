# misskey_db_log_manager

一定期間経過したMisskeyのdbログを自動で削除するスクリプト

## 使い方

1. `COMPOSE_FILE`・`SERVICE_NAME`・`LOG_DIR`・`COMPRESS_DAYS`・`DELETE_DAYS`を書き換えて設定する
2. `./misskey_db_log_manager.sh`でスクリプトを実行

## systemd timerで毎日午前2時に実行する

このリポジトリには、毎日 02:00 にスクリプトを実行するための `systemd` ユニットファイルを同梱しています。

1. `systemd/misskey-db-log-manager.service` の `ExecStart` を実際のスクリプト配置先に合わせて修正する
2. 次のコマンドでユニットを配置して有効化する

```sh
sudo cp systemd/misskey-db-log-manager.service /etc/systemd/system/
sudo cp systemd/misskey-db-log-manager.timer /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now misskey-db-log-manager.timer
```

3. タイマー状態を確認する

```sh
systemctl list-timers --all | grep misskey-db-log-manager
systemctl status misskey-db-log-manager.timer
```

手動実行テスト:

```sh
sudo systemctl start misskey-db-log-manager.service
sudo systemctl status misskey-db-log-manager.service
```
