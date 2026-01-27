#!/bin/bash
# Script Name: backup.sh
# Purpose: Storing log backup
# Author: Bijehn
# Date: 25-01-2026
#
mkdir -p ~/log_backup
cp /var/log/syslog ~/log_backup/syslog_backup.txt
echo "Log backup completed"

