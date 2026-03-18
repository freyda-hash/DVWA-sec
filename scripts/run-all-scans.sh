#!/usr/bin/env bash
set -euo pipefail

# Starts DVWA stack and runs all configured security scans.

# Ensure the stack is running

docker-compose up -d

# Wait for DVWA
for i in {1..30}; do
  if curl --silent --fail http://localhost/ >/dev/null 2>&1; then
    echo "DVWA is up"
    break
  fi
  sleep 2
done

# Run scans
mkdir -p .github/reports/{trivy,zap,sonar}

bash ./scripts/run-trivy.sh .github/reports/trivy/trivy-report.json
bash ./scripts/run-zap.sh .github/reports/zap/zap-report.html

if [[ -n "${SONAR_TOKEN:-}" ]]; then
  bash ./scripts/run-sonar.sh .github/reports/sonar/sonar-report.txt
else
  echo "Skipping SonarQube scan (SONAR_TOKEN not set)"
fi

# Cleanup

docker-compose down -v

echo "All scans completed. Reports are in .github/reports/"
