FROM ruby:2.7.2-slim-buster as base

WORKDIR /app

COPY Gemfile* ./

RUN apt-get update -qq && apt-get install -y --no-install-recommends libsqlite3-dev sqlite3 \
    libpq-dev postgresql-client curl build-essential software-properties-common && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs && \
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install yarn && \
    gem install rails -v 6.0.0 && \
    bundle install --jobs 20 --retry 5 && \
    apt-get remove -y curl build-essential libsqlite3-dev libpq-dev && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

FROM base AS app

EXPOSE 3000

CMD [ "bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000" ]
