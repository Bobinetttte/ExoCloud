# Déploiement Nextcloud sur Cloud Privé Infomaniak

## Objectif

Mettre en place un cloud SaaS privé Nextcloud sur une VM provisionnée via OpenStack CLI, avec volumes persistants, HTTPS, et sauvegarde quotidienne.

---

## Étapes d'installation et configuration

### 1. Provisionnement OpenStack

- Création VM avec image Ubuntu 22.04 LTS
- Allocation des volumes Cinder pour :
  - `/var/www/nextcloud/data` (données utilisateurs)
  - `/var/www/nextcloud/config` (configuration Nextcloud)
- Configuration réseau et clé SSH

### 2. Installation serveur

- Mise à jour et installation des paquets :
  - Apache2, MariaDB, PHP (avec extensions nécessaires)
- Configuration Apache pour Nextcloud
- Mise en place des permissions correctes sur `/var/www/nextcloud`

### 3. Installation Nextcloud

- Téléchargement et décompression de Nextcloud
- Déplacement dans `/var/www/nextcloud`
- Liaison des volumes persistants montés sur `/var/www/nextcloud/data` et `/var/www/nextcloud/config`

### 4. Sécurisation HTTPS

- Installation certbot et configuration SSL avec Apache
- Certificat généré pour le sous-domaine `kalvin.btn.cfpt.info`

### 5. Sauvegardes

- Script bash de sauvegarde incluant base MariaDB et volumes
- Tâche cron quotidienne pour automatiser la sauvegarde

---

## Notes supplémentaires

- UFW configuré pour autoriser les ports 22, 80, 443, 8080
- Le sous-domaine `kalvin.btn.cfpt.info` pointe vers l'IP publique de la VM
- Persistances des données assurées par les volumes Cinder OpenStack
