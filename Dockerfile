# ベースイメージ
FROM ruby:3.3.6

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# 作業ディレクトリ作成
WORKDIR /app

# Gemfileのコピー
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリファイルのコピー
COPY . .

# 環境変数
ARG APP_ENV=production
ENV APP_ENV ${APP_ENV} \
    RAILS_ENV=production

# ポート公開
EXPOSE 3000

# サーバー起動コマンド
CMD [ "rails", "server", "-b", "0.0.0.0" ]