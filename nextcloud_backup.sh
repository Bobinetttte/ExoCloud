#!/bin/bash

# Variables
BACKUP_DIR="/backups/nextcloud"
DATE=$(date +%F)
DB_NAME="nextcloud"
DB_USER="roott"        # Ne pas mettre en public sur git mais cest plus simple comme ca
DB_PASS="Super123$"     # Ne pas mettre en public sur git mais cest plus simple comme ca
DATA_DIR="/var/www/nextcloud/data"
CONFIG_DIR="/var/www/nextcloud/config"

# Créer dossier backup si besoin
mkdir -p "$BACKUP_DIR"

# Sauvegarder la base de données
mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_DIR/nextcloud_db_$DATE.sql"

# Sauvegarder les dossiers data et config
tar -czf "$BACKUP_DIR/nextcloud_data_$DATE.tar.gz" -C "$DATA_DIR" .
tar -czf "$BACKUP_DIR/nextcloud_config_$DATE.tar.gz" -C "$CONFIG_DIR" .

# Optionnel : supprimer les backups de plus de 7 jours
find "$BACKUP_DIR" -type f -mtime +7 -exec rm -f {} \;

echo "Backup terminé pour $DATE"
