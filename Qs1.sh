#!/bin/bash

# Define variables
backupDir="/home/sadeem/backup"
backupFile="system_backup_$(date +%d%m%y).tar.gz"
encryptedBackupFile="$backupDir/system_backup_$(date +%d%m%y).tar.gz.gpg"
email="sadeem1212@hotmail.com"

# Check if backup directory exists, create if not
if [ ! -d "$backupDir" ]; then
    mkdir -p "$backupDir"
fi

# Create backup (excluding some directories that are typically not needed)
sudo tar -czvf "$backupDir/$backupFile" --exclude=/proc --exclude=/sys --exclude=/dev --exclude=/run --exclude=/mnt --exclude=/media --exclude=/lost+found --one-file-system /

# Encrypt backup file
echo "Your Passphrase" | gpg --batch --symmetric --output "$encryptedBackupFile" --passphrase-fd 0 "$backupDir/$backupFile"

# Send email
if command -v mutt &> /dev/null
then
    echo "Weekly system backup file" | mutt -s "Weekly System Backup" -a "$encryptedBackupFile" -- "$email"
else
    echo "Sending email via sendmail"
    echo "Subject: Weekly System Backup" | cat - "$encryptedBackupFile" | /usr/sbin/sendmail -t "$email"
fi
