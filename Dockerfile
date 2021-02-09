FROM ruby:2.7.2-slim-buster as base

WORKDIR /app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN apt-get update -qq && apt-get install -y --no-install-recommends curl gawk autoconf automake bison \
    libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev libtool libyaml-dev pkg-config sqlite3 \
    zlib1g-dev libgmp-dev libreadline-dev libssl-dev libpq-dev nodejs npm postgresql-client \
    ca-certificates build-essential && \
    npm install -g yarn && \
    gem install rails -v 6.0.0 && \
    bundle install --jobs 20 --retry 5 && \
    apt-get remove -y libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev zlib1g-dev libgmp-dev libreadline-dev \
                    libssl-dev libpq-dev curl gawk autoconf automake build-essential && \
    rm -rf /var/lib/apt/lists/

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

FROM base AS app

EXPOSE 3000

CMD [ "bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000" ]