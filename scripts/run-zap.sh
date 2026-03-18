#!/usr/bin/env bash
set -euo pipefail

# Run OWASP ZAP baseline scan against the local DVWA instance.
# Requires docker-compose to have started DVWA (listening on http://localhost).

REPORT_PATH="${1:-}"
if [[ -z "$REPORT_PATH" ]]; then
  REPORT_PATH="zap-report.html"
fi

TARGET_URL="${TARGET_URL:-http://localhost/}"

mkdir -p "$(dirname "$REPORT_PATH")"

docker run --rm \
  -v "$PWD":/zap/wrk/:rw \
  owasp/zap2docker-stable \
  zap-baseline.py \
    -t "$TARGET_URL" \
    -r "$(basename "$REPORT_PATH")" \
    -d \
    -z "-config api.disablekey=true"

mv "$(basename "$REPORT_PATH")" "$REPORT_PATH" 2>/dev/null || true

echo "ZAP scan report written to $REPORT_PATH"
