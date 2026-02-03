#!/bin/bash

DATE=$(date +%F)

tar -cvzf /home/$USER/devops/Day-6/backups/backup_$DATE.tar.gz \
/home/$USER/devops/Day-6/app \
/home/$USER/devops/Day-6/logs \
/home/$USER/devops/Day-6/config
