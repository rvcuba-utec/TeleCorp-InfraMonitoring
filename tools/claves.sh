#!/usr/bin/env bash
# Muestra las claves inbound (las que se entregan a Azure/GCP/antenas) guardadas localmente.
cd "$(dirname "$0")/.."
f=.local-env/claves.json
[ -f "$f" ] && cat "$f" || echo "No hay claves locales. Ejecuta ./deploy.sh (o python tools/bootstrap_secrets.py --show)." >&2
