# DVWA-secDéploiement de DVWA avec GitHub Actions et intégration d'analyses SAST (SonarQube), SCA & container scanning (Trivy) et DAST (OWASP ZAP).

## Objectif

- Détecter et corriger les vulnérabilités de DVWA via des outils de sécurité dans le pipeline.
- Bloquer le déploiement si une faille critique est détectée.
- Générer des rapports de sécurité automatiquement.

## Structure du projet

- `docker-compose.yml` : déploie une instance DVWA + MySQL localement.
- `.github/workflows/security.yml` : pipeline CI qui exécute Trivy, ZAP et SonarQube.
- `scripts/run-trivy.sh` : lance un scan Trivy sur l'image DVWA.
- `scripts/run-zap.sh` : lance un scan DAST OWASP ZAP contre l'instance locale.
- `scripts/run-sonar.sh` : lance un scan SonarQube .
- `scripts/run-all-scans.sh` : exécute l'ensemble des scans en local (Trivy + ZAP + Sonar si configuré).

## Usage local

1. Démarrer l'application DVWA :

```bash
docker-compose up -d
```

2. Ouvrir l'application dans un navigateur :

```
http://localhost/
```

3. Arrêter / nettoyer :

```bash
docker-compose down -v
```

## Exécuter les scans localement

### Trivy (container scanning)

```bash
./scripts/run-trivy.sh .github/reports/trivy/trivy-report.json
```

### OWASP ZAP (DAST)

```bash
./scripts/run-zap.sh .github/reports/zap/zap-report.html
```

### SonarQube (SAST)

Ce scan nécessite un token SonarQube (ou SonarCloud) stocké dans la variable d'environnement `SONAR_TOKEN`.

```bash
export SONAR_TOKEN="<votre-token>"
./scripts/run-sonar.sh .github/reports/sonar/sonar-report.txt
```

## CI GitHub Actions

Le workflow `security.yml` se déclenche sur `push` et `pull_request`.
Il démarre un stack DVWA, exécute les scans de sécurité et publie les rapports en tant qu'artéfacts.

