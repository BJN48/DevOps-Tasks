
---

# Day 11 – Multi-Container Application using Docker Compose

## Overview

This task focuses on building and managing a **multi-container application** using **Docker Compose**.
The setup includes an **NGINX web server** acting as a reverse proxy and a **Python application service**, both running in separate containers and connected through a custom Docker network.

The goal is to understand how multiple services work together, how they communicate internally, and how Docker Compose simplifies orchestration.

---

## Why Multi-Container Applications Are Needed

Modern applications are not single processes. They usually consist of:

* A web server
* An application service
* Optional databases, caches, or background workers

Running everything in one container makes scaling, debugging, and maintenance difficult.
Docker Compose allows each component to run in its **own container** while still functioning as a single application.

---

## Technologies Used

* Docker
* Docker Compose
* NGINX
* Python (http.server)
* WSL (Ubuntu)

---

## Project Structure (Conceptual)

* **NGINX container**

  * Acts as a reverse proxy
  * Forwards incoming requests to the application container
* **Application container**

  * Runs a Python HTTP server on port 5000
* **Custom Docker network**

  * Enables service-to-service communication using service names
* **Bind-mounted NGINX configuration**

  * Custom `nginx.conf` is mounted into the NGINX container

---

## Docker Compose Configuration (Explanation)

The `docker-compose.yml` file defines:

* Multiple services (`web`, `app`)
* A shared custom network
* Service dependencies
* Volume binding for custom NGINX configuration

### Key Configuration Concepts Used

* **Services**
  Each service runs in its own container.

* **depends_on**
  Ensures the application service starts before NGINX.

* **Networks**
  Allows NGINX to communicate with the application using the service name (`app`).

* **Volumes (Bind Mount)**
  The custom `nginx.conf` file is mounted into the NGINX container at runtime so NGINX uses the custom reverse-proxy configuration.

---

## NGINX Reverse Proxy Setup (Conceptual)

You configured NGINX to:

* Listen on port 80 inside the container
* Forward incoming requests to the application service running on port 5000
* Use the **Docker service name (`app`)** as the backend hostname

This works because Docker Compose provides internal DNS resolution between services on the same network.

---

## Commands Used and Their Purpose

### Start all services

```bash
docker compose up -d
```

**Purpose:**
Creates the network, volumes, and containers, then starts all services in detached mode.

---

### Verify running containers

```bash
docker ps
```

**Purpose:**
Displays all running containers managed by Docker.

---

### Scale the application service

```bash
docker compose up -d --scale app=3
```

**Purpose:**
Runs multiple instances of the application service to demonstrate horizontal scaling.

---

### Stop and remove containers, networks

```bash
docker compose down
```

**Purpose:**
Stops all running services and removes containers and networks created by Docker Compose.

---

### Remove containers, networks, and volumes

```bash
docker compose down -v
```

**Purpose:**
Performs a complete cleanup, including removing associated volumes.

---

## Service Interaction Flow

1. A user sends a request to the exposed NGINX port.
2. The request reaches the **NGINX container**.
3. NGINX forwards the request to the **application service** using the internal Docker network.
4. The application service processes the request and sends a response back to NGINX.
5. NGINX returns the response to the user.

---

## Key Learning Outcomes

* Understanding the need for multi-container applications
* Writing and using a `docker-compose.yml` file
* Defining services, networks, volumes, and dependencies
* Using NGINX as a reverse proxy inside Docker
* Scaling services with Docker Compose
* Properly stopping and cleaning Docker environments
* Understanding container-to-container communication

---

## Conclusion

This task demonstrates how Docker Compose simplifies managing complex applications made up of multiple containers. By separating responsibilities across services and using a reverse proxy, the application becomes more scalable, maintainable, and production-ready.

---

