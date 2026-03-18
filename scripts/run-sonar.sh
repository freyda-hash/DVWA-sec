#!/usr/bin/env bash
set -euo pipefail

SONAR_HOST_URL="${SONAR_HOST_URL:-https://sonarcloud.io}"
SONAR_TOKEN="${SONAR_TOKEN:?SONAR_TOKEN is required for SonarQube analysis}" 
SONAR_PROJECT_KEY="${SONAR_PROJECT_KEY:-dvwa-sec}"
SONAR_ORGANIZATION="${SONAR_ORGANIZATION:-}"
REPORT_PATH="${1:-}"

if [[ -z "$REPORT_PATH" ]]; then
  REPORT_PATH="sonar-report.txt"
fi

mkdir -p "$(dirname "$REPORT_PATH")"

ARGS=("-Dsonar.projectKey=$SONAR_PROJECT_KEY" "-Dsonar.host.url=$SONAR_HOST_URL" "-Dsonar.login=$SONAR_TOKEN" "-Dsonar.sources=.")
if [[ -n "$SONAR_ORGANIZATION" ]]; then
  ARGS+=("-Dsonar.organization=$SONAR_ORGANIZATION")
fi

docker run --rm \
  -v "$PWD":/usr/src \
  -w /usr/src \
  sonarsource/sonar-scanner-cli:latest \
  "${ARGS[@]}" | tee "$REPORT_PATH"

echo "SonarQube report written to $REPORT_PATH"
