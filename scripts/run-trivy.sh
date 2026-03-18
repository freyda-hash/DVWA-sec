#!/usr/bin/env bash
set -euo pipefail

# Trivy expects a docker image to scan. 
IMAGE="vulnerables/web-dvwa:latest"
REPORT_PATH="${1:-}"

if [[ -z "$REPORT_PATH" ]]; then
  REPORT_PATH="trivy-report.json"
fi

SEVERITY="${TRIVY_SEVERITY:-CRITICAL}"

mkdir -p "$(dirname "$REPORT_PATH")"

docker pull "$IMAGE"

docker run --rm \
  -v "$PWD":/workspace \
  aquasec/trivy:latest \
  image --exit-code 1 --severity "$SEVERITY" --format json --output "/workspace/$REPORT_PATH" "$IMAGE"

echo "Trivy scan results written to $REPORT_PATH"
