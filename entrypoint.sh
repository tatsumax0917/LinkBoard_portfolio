#!/bin/bash
set -e

# 既存のサーバーPIDファイルがあれば削除します。
echo "既存のサーバーPIDファイルを削除します..."
rm -f /app/tmp/pids/server.pid

if [ "$RAILS_ENV" = "development" ]; then
    echo "Development環境で起動中..."
elif [ "$RAILS_ENV" = "production" ]; then
    echo "Production環境で起動中..."
    # 古いアセットをクリーンアップする
    echo "古いアセットをクリーンアップ中..."
    bundle exec rake assets:clobber
    # 本番環境用にアセットをプリコンパイル
    echo "アセットをプリコンパイル中..."
    bundle exec rake assets:precompile
    # 古いアセットをクリーンアップする
    # echo "古いアセットクリーンアップ中..."
    # bundle exec rake assets:clean
else
    echo "未知の環境: $RAILS_ENV"
    exit 1
fi

# 新規コンテナ立ち上げ時にはデータベースの作成とマイグレーションが必要です。
if ! bundle exec rake db:version >/dev/null 2>&1; then
    echo "データベースが存在しなかったので作成中..."
    bundle exec rake db:create
fi

echo "マイグレーション中..."
bundle exec rake db:migrate

# # wheneverの設定
# echo "wheneverにCron登録..."
# bundle exec whenever --update-crontab
# crontab -l
# # cronサービスを開始
# echo "Cronを起動します"
# service cron start
# service cron status

# Dockerfileで指定されたCMDコマンドを実行します。
exec "$@"