#!/bin/sh
set -e

echo "Applying database migrations..."
uv run python manage.py migrate --noinput

echo "Collecting static files..."
uv run python manage.py collectstatic --noinput

# Prometheus multiprocess mode for Gunicorn
export PROMETHEUS_MULTIPROC_DIR=/tmp/django_prometheus_multiproc
rm -rf "$PROMETHEUS_MULTIPROC_DIR"
mkdir -p "$PROMETHEUS_MULTIPROC_DIR"

exec "$@"
