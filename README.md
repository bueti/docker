# Rails 6

Easy to use docker image pre-installed with Rails 6, Postgres, NodeJS 14 LTS, Yarn, and Tailwind 2.0.0.

## How to use it

I am using it as part of a docker-compose workflow:

In your rails application root create a `docker-compose.yml` with the following content:

```yaml
version: "3.9"
services:
  db:
    image: postgres
    volumes:
      - ./tmp/db:/var/lib/postgresql/data
    environment:
      POSTGRES_PASSWORD: password
  web:
    image: docker.io/bueti/rails:latest
    command: bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"
    volumes:
      - .:/app
    ports:
      - "3000:3000"
    depends_on:
      - db

```

To initialize your rails up run:

```sh
$ docker-compose run --no-deps web rails new . --force --database=postgresql
```

Or just start it  up with:

```sh
$ docker-compose up
```

If you use your own Gemfile you might need to run `bundle update` first:

```sh
$ docker-compose run web bundle update
```
