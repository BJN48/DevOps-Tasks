
---

#  DevOps Day 7 Task : Environment Variables Management (Linux / WSL)

## Overview

This task focuses on understanding and managing **environment variables** in a Linux system using WSL.
It covers viewing existing variables, creating custom variables, safely modifying the `PATH`, making changes persistent, testing configurations, and debugging common `PATH` issues.

All steps are performed using **safe, non-destructive methods** suitable for public repositories.

---

## Prerequisites

* Linux environment (WSL – Ubuntu)
* Basic terminal usage

---

## 1. Viewing Environment Variables

### Command Used

```bash
printenv | grep -E "USER|HOME|SHELL|PATH"
```

### Function

* `printenv` displays environment variables.
* `grep` filters output to show only common, non-sensitive variables.
* Helps inspect the environment without exposing confidential data.

---

### Command Used

```bash
echo $PATH
```

### Function

* Displays the current `PATH` variable.
* `PATH` defines where the system looks for executable commands.

---

## 2. Creating Custom Environment Variables

### Command Used

```bash
export DEVOPS_DAY=7
```

### Function

* Creates a custom environment variable.
* The variable is available to the current shell session.

---

### Command Used

```bash
echo $DEVOPS_DAY
```

### Function

* Verifies that the custom variable is set correctly.

---

## 3. Modifying the PATH Variable (Safe Method)

### Command Used

```bash
mkdir -p ~/mybin
```

### Function

* Creates a user-level directory for custom executables.
* Avoids modifying system directories.

---

### Command Used

```bash
export PATH="$PATH:$HOME/mybin"
```

### Function

* Appends a custom directory to the existing `PATH`.
* Ensures system paths remain intact.

---

### Command Used

```bash
echo $PATH | grep mybin
```

### Function

* Confirms that the custom directory has been added to `PATH`.

---

## 4. Making Variables Persistent

### Command Used

```bash
nano ~/.bashrc
```

### Function

* Opens the shell configuration file that runs on every terminal start.

---

### Configuration Added

```bash
export DEVOPS_DAY=7
export PATH="$PATH:$HOME/mybin"
```

### Function

* Ensures environment variables and `PATH` changes persist across sessions.

---

### Command Used

```bash
source ~/.bashrc
```

### Function

* Reloads the configuration file without restarting the terminal.

---

## 5. Testing Persistence

### Command Used

```bash
echo $DEVOPS_DAY
```

### Function

* Confirms the custom variable persists after reload.

---

### Command Used

```bash
echo $PATH | grep mybin
```

### Function

* Verifies that the `PATH` modification is persistent.

---

## 6. Debugging PATH Issues

### Command Used

```bash
which ls
```

### Function

* Displays the exact path of a command.
* Useful for identifying which directory a command is executed from.

---

### Command Used

```bash
echo $PATH | tr ':' '\n'
```

### Function

* Prints each `PATH` directory on a new line.
* Helps visually debug incorrect or missing paths.


---

## Final Outcome

* Safely viewed environment variables
* Created and verified custom variables
* Modified `PATH` without affecting system stability
* Made environment variables persistent
* Tested and debugged `PATH` issues correctly

---
