#éploiement de DVWA avec GitHub Actions et intégration d'analyses SAST (SonarQube), SCA & container scanning (Trivy) et DAST (OWASP ZAP).

## Objectif

- Détecter et corriger les vulnérabilités de DVWA via des outils de sécurité dans le pipeline.
- Bloquer le déploiement si une faille critique est détectée.
- Générer des rapports de sécurité automatiquement.



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






