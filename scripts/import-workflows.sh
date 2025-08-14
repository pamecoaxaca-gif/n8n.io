#!/bin/bash
# Importa workflows desde workflows-export/workflows.json a n8n (sobrescribe los existentes)

set -e

N8N_USER=${N8N_USER:-admin}
N8N_PASS=${N8N_PASS:-changeme}
N8N_HOST=${N8N_HOST:-http://localhost:5678}

WORKFLOWS_FILE="workflows-export/workflows.json"

if [ -f "$WORKFLOWS_FILE" ]; then
  workflows=$(jq -c '.data[]' "$WORKFLOWS_FILE")
  for wf in $workflows; do
    id=$(echo $wf | jq '.id')
    # Actualiza si existe, crea si no
    curl -u $N8N_USER:$N8N_PASS -X PATCH \
      -H "Content-Type: application/json" \
      "$N8N_HOST/rest/workflows/$id" \
      -d "$wf" ||
    curl -u $N8N_USER:$N8N_PASS -X POST \
      -H "Content-Type: application/json" \
      "$N8N_HOST/rest/workflows" \
      -d "$wf"
  done
fi