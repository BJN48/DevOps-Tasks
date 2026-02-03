---

# DevOps Backup Automation Using tar, gzip, Shell Script, and Cron (WSL)

## Objective

To create sample files, compress them using `tar` and `gzip`, automate backups using a shell script, schedule the backup using `cron`, and verify the backups in a Linux environment (WSL).

---

## Tools Used

* Ubuntu (WSL)
* Bash Shell
* tar
* gzip
* cron

---

## 1. Create Sample Files

```bash
echo "Application data" > app.txt
echo "Log data" > log.txt
echo "Config data" > config.txt
```

**Purpose:**
Creates sample files to simulate application, log, and configuration data.

---

## 2. Compress Files Using tar and gzip

```bash
tar -cvzf devops_backup.tar.gz app.txt log.txt config.txt
```

**Purpose:**

* `tar` creates an archive
* `-c` create
* `-v` verbose
* `-z` gzip compression
* `-f` output file

Creates a compressed backup archive.

---

## 3. Extract Compressed Files

```bash
tar -xvzf devops_backup.tar.gz
```

**Purpose:**
Extracts and restores files from the compressed archive.

---

## 4. Automate Backup Using Shell Script

Create script:

```bash
nano backup.sh
```

Script content:

```bash
#!/bin/bash

DATE=$(date +%F)

tar -cvzf /home/$USER/devops/Day-6/backups/backup_$DATE.tar.gz \
/home/$USER/devops/Day-6/app.txt \
/home/$USER/devops/Day-6/log.txt \
/home/$USER/devops/Day-6/config.txt
```

Make executable:

```bash
chmod +x backup.sh
```

Run manually:

```bash
./backup.sh
```

**Purpose:**
Automates backup creation and appends the current date to prevent overwriting.

---

## 5. Schedule Backup Using Cron

Edit cron jobs:

```bash
crontab -e
```

Cron entry:

```bash
*/2 * * * * /home/$USER/devops/Day-6/backup.sh
```

**Purpose:**
Runs the backup script automatically every 2 minutes.

Verify cron job:

```bash
crontab -l
```

---

## 6. Verify Backups

List backups:

```bash
ls -lh backups
```

Check archive contents:

```bash
tar -tvf backup_YYYY-MM-DD.tar.gz
```

Verify gzip integrity:

```bash
gzip -t backup_YYYY-MM-DD.tar.gz
```

**Purpose:**
Ensures backups are created correctly and are not corrupted.

---

## Conclusion

This task demonstrates a complete backup automation workflow using Linux command-line tools, shell scripting, and cron scheduling, following standard DevOps practices.

---
