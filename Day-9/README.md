Below is a **professional, GitHub-ready README.md** for your Docker DevOps task.
It is **clean**, **beginner-friendly**, and **command-focused** (with purpose explained).
You can **directly copy–paste** this into your repository.

---

# Docker Basics – DevOps Task (WSL)

## Overview

This task demonstrates the complete Docker workflow using **WSL (Ubuntu)**.
It covers installing Docker, creating a simple application, containerizing it using a Dockerfile, building and running Docker images, inspecting containers, and performing cleanup operations.

The goal is to understand **what Docker does, why each command is used, and how containers work in practice**.

---

## Environment

* OS: Ubuntu (via WSL)
* Container Platform: Docker
* Application Type: Python Flask Web Application

---

## 1. Docker Installation & Verification

### Commands Used

```bash
sudo apt update
sudo apt install docker.io -y
```

**Function**

* Updates the package list and installs Docker Engine on Ubuntu.

```bash
docker version
docker info
```

**Function**

* `docker version` verifies Docker client and server installation.
* `docker info` confirms Docker daemon status and system-level details.

---

## 2. Application Creation & Runtime Understanding

A simple Python Flask web application was created.

### Runtime Requirements

* Python 3
* Flask library
* Port 5000

These requirements are handled inside the Docker container, not on the host system.

---

## 3. Dockerfile Creation

A Dockerfile defines how the Docker image is built.

### Dockerfile Responsibilities

* Select a base image
* Set working directory
* Install dependencies
* Copy application code
* Expose required port
* Define startup command

---

## 4. Docker Image Build

### Command Used

```bash
docker build -t my-python-app .
```

**Function**

* Builds a Docker image from the Dockerfile.
* `-t` assigns a meaningful tag to the image.
* `.` specifies the current directory as the build context.

### Verification

```bash
docker images
```

**Function**

* Lists all available Docker images on the system.

---

## 5. Running the Docker Container

### Command Used

```bash
docker run -d -p 5000:5000 --name myapp-container my-python-app
```

**Function**

* Creates and starts a container from the image.
* `-d` runs the container in detached mode.
* `-p 5000:5000` maps host port to container port.
* `--name myapp-container` assigns a custom container name.

---

## 6. Inspecting Containers & Logs

### Commands Used

```bash
docker ps
```

**Function**

* Displays running containers and their status.

```bash
docker logs myapp-container
```

**Function**

* Shows application output and runtime logs.

```bash
docker inspect myapp-container
```

**Function**

* Provides detailed container configuration and metadata.

---

## 7. Stopping & Cleaning Docker Resources

### Stop Container

```bash
docker stop myapp-container
```

**Function**

* Gracefully stops the running container.

### Remove Container

```bash
docker rm myapp-container
```

**Function**

* Deletes the stopped container.

### Remove Image

```bash
docker rmi my-python-app
```

**Function**

* Deletes the Docker image from the system.

### System Cleanup

```bash
docker system prune
```

**Function**

* Removes unused containers, images, and cache to free disk space.

---

## 8. Docker Image Lifecycle

```
Dockerfile
   ↓
Docker Image
   ↓
Docker Container
   ↓
Stopped Container
   ↓
Removed
```

---

## Final Outcome

* Docker installed and verified on WSL
* Application containerized using Dockerfile
* Image built and tagged correctly
* Container executed with port mapping
* Logs and container state inspected
* Proper cleanup performed

This task provides hands-on understanding of **Docker fundamentals and container lifecycle**, which are essential for DevOps roles.

---

If you want, I can next:

* Tighten this README for **interview review**
* Convert this into a **DevOps internship task report**
* Add **screenshots section format**
* Prepare **Docker interview questions based on this task**

Say what you want next.
