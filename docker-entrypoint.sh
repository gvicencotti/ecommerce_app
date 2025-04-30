#!/bin/bash
set -e

rm -f /rails/tmp/pids/server.pid

echo "Waiting for PostgreSQL to become available..."
until PGPASSWORD=$DATABASE_PASSWORD pg_isready -h $DATABASE_HOST -p $DATABASE_PORT -U $DATABASE_USERNAME; do
  sleep 2
done

echo "PostgreSQL is ready!"

bundle exec rake db:create db:migrate db:seed

exec "$@"
