
---

# Process Management & Service Monitoring – DevOps Task

## Overview

This task focuses on **Linux process management and service control** using **WSL (Ubuntu)**.
The objective is to understand how processes work, how to control them, and how to monitor system resources — which are **core DevOps skills**.

---

## Environment Used

* **OS**: Ubuntu (via Windows Subsystem for Linux – WSL)
* **User Level**: Beginner
* **Tools**: Linux built-in utilities

---

## Task Objectives

* List running processes
* Monitor processes in real time
* Kill normal and unresponsive processes
* Understand process states
* Start, stop, and manage services
* Enable services at boot
* Monitor system resource usage
* Record findings

---

## 1. Listing Running Processes

### Command: `ps`

```bash
ps
```

**Function**:
Displays processes running in the current terminal session.

---

### Command: `ps aux`

```bash
ps aux
```

**Function**:
Lists **all running processes** in the system with CPU and memory usage.

Key fields:

* `PID` – Process ID
* `%CPU` – CPU usage
* `%MEM` – Memory usage
* `COMMAND` – Running command

---

### Command: `top`

```bash
top
```

**Function**:
Shows **real-time process activity** including CPU and RAM usage.

Exit using:

```text
q
```

---

## 2. Killing Processes

### Creating a test process

```bash
sleep 300
```

**Function**:
Creates a temporary running process for testing.

---

### Finding the process ID

```bash
ps aux | grep sleep
```

**Function**:
Finds the PID of the `sleep` process.

---

### Normal process termination

```bash
kill <PID>
```

**Function**:
Gracefully stops the process.

---

### Forceful process termination

```bash
kill -9 <PID>
```

**Function**:
Immediately terminates an unresponsive process.
Used only when normal `kill` fails.

---

## 3. Understanding Process States

### Command

```bash
ps -eo pid,stat,cmd
```

**Common Process States**:

* `R` – Running
* `S` – Sleeping
* `T` – Stopped
* `Z` – Zombie (terminated but not cleaned)

---

## 4. Service Management Using systemctl

### Checking service status

```bash
systemctl status cron
```

**Function**:
Displays current status of the service.

---

### Starting a service

```bash
sudo systemctl start cron
```

---

### Stopping a service

```bash
sudo systemctl stop cron
```

---

### Restarting a service

```bash
sudo systemctl restart cron
```

---

## 5. Enabling Services at Boot

### Enable service

```bash
sudo systemctl enable cron
```

**Function**:
Starts the service automatically on system boot.

---

### Disable service

```bash
sudo systemctl disable cron
```

---

### Verify enable status

```bash
systemctl is-enabled cron
```

---

## 6. Monitoring System Resources

### CPU and memory (live)

```bash
top
```

---

### Memory usage

```bash
free -h
```

---

### Disk usage

```bash
df -h
```

---

### System load

```bash
uptime
```

---

## Final Outcome

* Gained hands-on experience with **Linux process management**
* Learned **service control using systemctl**
* Understood **resource monitoring**
* Created a documented **process management report**

---