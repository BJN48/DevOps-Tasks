
---

# Day 10 – Docker Volumes and Networking

## Objective

The objective of this task is to understand **data persistence in Docker containers** using volumes and to learn **container-to-container communication** using custom Docker networks. This task demonstrates why volumes and networks are critical in real-world DevOps workflows.

---

## Prerequisites

* Docker installed and running
* WSL (Ubuntu) environment
* Docker images available locally:

  * `python:3.9`
  * `nginx:latest`

---

## Task Overview

This task covers:

* Data loss issue in containers
* Docker volumes creation and usage
* Data persistence verification
* Custom Docker networks
* Container communication using network aliases
* Inspecting Docker resources
* Confirming data persistence after container removal

---

## 1. Understanding Data Loss in Containers

### Problem

Docker containers are **ephemeral**. Any data stored inside a container is lost when the container is removed.

### Reason

Container filesystems are destroyed along with the container.

### Solution

Docker **volumes** are used to store data outside the container lifecycle, ensuring persistence.

---

## 2. Creating a Docker Volume

### Command

```bash
docker volume create mydata
```

### Function

Creates a Docker-managed volume named `mydata` to store persistent data.

### Verification

```bash
docker volume ls
```

---

## 3. Attaching Volume to a Container

### Command

```bash
docker run -it --name python-vol-test -v mydata:/data python:3.9 bash
```

### Function

* Runs a Python container
* Mounts the `mydata` volume to `/data` inside the container
* Enables persistent storage for application data

---

## 4. Storing Data in the Volume

### Commands (inside container)

```bash
cd /data
echo "Docker volumes prevent data loss" > info.txt
ls
```

### Function

Stores application data inside the mounted volume.

### Exit container

```bash
exit
```

---

## 5. Removing Container to Test Data Persistence

### Command

```bash
docker rm python-vol-test
```

### Function

Deletes the container to test whether the stored data persists independently of the container.

---

## 6. Reusing Volume in a New Container

### Command

```bash
docker run -it --name python-vol-test2 -v mydata:/data python:3.9 bash
```

### Verification (inside container)

```bash
cd /data
cat info.txt
```

### Result

The file is still available, confirming data persistence using Docker volumes.

---

## 7. Creating a Custom Docker Network

### Command

```bash
docker network create mynetwork
```

### Function

Creates an isolated Docker network to allow controlled container-to-container communication.

### Verification

```bash
docker network ls
```

---

## 8. Running NGINX Container on Custom Network

### Command

```bash
docker run -d --name web --network mynetwork --network-alias myweb nginx:latest
```

### Function

* Runs NGINX in detached mode
* Connects container to `mynetwork`
* Assigns `myweb` as a network alias for service discovery

---

## 9. Running Python Container on Same Network

### Command

```bash
docker run -it --name client --network mynetwork python:3.9 bash
```

### Function

Runs a client container that can communicate with other containers on the same network.

---

## 10. Testing Container-to-Container Communication

### Commands (inside Python container)

```bash
apt update
apt install -y curl
curl http://myweb
```

### Function

* Installs `curl`
* Accesses the NGINX container using its network alias
* Confirms successful inter-container communication

---

## 11. Inspecting Docker Volume

### Command

```bash
docker volume inspect mydata
```

### Function

Displays volume metadata, mount location, and configuration details.

---

## 12. Inspecting Docker Network

### Command

```bash
docker network inspect mynetwork
```

### Function

Shows connected containers, IP addressing, and network configuration.

---

## 13. Removing Containers

### Command

```bash
docker rm -f web client python-vol-test2
```

### Function

Removes all running and stopped containers used in this task.

---

## 14. Verifying Volume Persistence

### Command

```bash
docker volume ls
```

### Result

The `mydata` volume still exists, confirming that data is retained even after container removal.

---

## Final Outcome

* Demonstrated why containers alone are not suitable for persistent data
* Successfully used Docker volumes for data persistence
* Implemented custom Docker networking
* Verified container-to-container communication using network aliases
* Inspected Docker volumes and networks
* Confirmed data persistence after container deletion

---

