FROM ruby:3.2.4

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  # libpq-dev \ 
  nodejs \
  npm \
  vim \
  # cron \
  # postgresql-client \
  sudo

RUN npm install -g npm@latest

WORKDIR /app

# GemfileとGemfile.lockをコピーし、バンドルインストール
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

# npmの依存関係をインストール
COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
RUN npm install

# アプリケーションのソースコードをコピー
COPY . /app

# entrypointの設定
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD [ "rails","server","-b","0.0.0.0" ]
