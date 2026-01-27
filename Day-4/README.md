
---

# DevOps Daily Task – Shell Scripting Using WSL

## Overview

This task focuses on learning **Linux shell scripting basics** using **Ubuntu on WSL**.
To clearly understand each concept, **separate shell scripts were created for each task** instead of combining everything into one file.

---

## Script Details

### system_info.sh

Prints basic system information such as:

* Hostname
* Current user
* Date and time
* System uptime
* Disk usage
* Memory usage

---

### variable.sh

Demonstrates the use of **variables** in shell scripting.

* Stores values like username and date in variables
* Prints the values using variable references

---

### file_condition.sh

Demonstrates **conditional statements (if–else)**.

* Checks whether a **specific file exists**
* Prints a message indicating whether the file is present or not

---

### count.sh

Demonstrates the use of **loops and file processing**.

* Counts the **number of lines in a file**
* Displays the total line count

---

### backup.sh

Demonstrates **basic automation**.

* Creates a backup location if it does not exist
* Copies a log file to the backup location

---

## Commands Used

### Create shell script files

```bash
touch system_info.sh variable.sh file_condition.sh count.sh backup.sh
```

### Add shebang line in each script

```bash
#!/bin/bash
```

### Make scripts executable

```bash
chmod +x *.sh
```

### Run scripts

```bash
./system_info.sh
./variable.sh
./file_condition.sh
./count.sh
./backup.sh
```

### Redirect output to a file

```bash
./system_info.sh > output.txt
```

---

## Environment

* Operating System: Ubuntu (WSL)
* Shell: Bash

---

## Learning Outcome

This task helped me understand:

* How to create and execute shell scripts
* Use of variables in Bash
* File existence checks using conditionals
* Reading and counting lines in a file
* Automating simple backup tasks
* Redirecting command output to files
* Writing modular and readable scripts

---

## Author

Bijehn Saji



