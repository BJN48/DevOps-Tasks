
---

# DevOps Day 13 – System Monitoring with Prometheus & Grafana

## Overview

This project demonstrates how to set up **system monitoring on a local machine (WSL – Ubuntu)** using **Prometheus** and **Grafana**.
The goal is to collect system metrics (CPU, memory, disk), store them as time-series data, and visualize them using dashboards.

This setup helps understand **how monitoring works in real DevOps environments**.

---

## Tools Used

* **Prometheus** – Metrics collection and storage
* **Node Exporter** – Exposes system metrics
* **Grafana** – Visualization and dashboards
* **stress** – Simulates system load
* **WSL (Ubuntu)** – Local Linux environment

---

## Architecture (Simple Explanation)

* **Node Exporter** reads system metrics (CPU, memory, disk)
* **Prometheus** periodically scrapes these metrics
* **Grafana** queries Prometheus and displays graphs

---

## Step-by-Step Implementation

### 1️⃣ Update System Packages

```bash
sudo apt update
```

**Purpose:**
Ensures the system has the latest package information before installing software.

---

### 2️⃣ Install Prometheus

```bash
sudo apt install prometheus -y
```

**What happens:**

* Installs Prometheus as a background service
* Creates a default configuration file
* Starts listening on port `9090`

**Verify:**

```bash
systemctl status prometheus
```

---

### 3️⃣ Access Prometheus UI

```
http://localhost:9090
```

**Use:**

* Verify Prometheus is running
* Test metric queries
* Check scrape targets

---

### 4️⃣ Install Node Exporter

```bash
sudo apt install prometheus-node-exporter -y
```

**Purpose:**
Node Exporter collects system-level metrics such as CPU usage, memory usage, and disk statistics.

**Verify:**

```bash
systemctl status prometheus-node-exporter
```

**Metrics Endpoint:**

```
http://localhost:9100/metrics
```

---

### 5️⃣ Configure Prometheus to Scrape System Metrics

Open Prometheus configuration:

```bash
sudo nano /etc/prometheus/prometheus.yml
```

Add the following under `scrape_configs`:

```yaml
  - job_name: "node_exporter"
    static_configs:
      - targets: ["localhost:9100"]
```

Restart Prometheus:

```bash
sudo systemctl restart prometheus
```

**Purpose:**
Allows Prometheus to periodically collect system metrics from Node Exporter.

---

### 6️⃣ Verify Scraping Status

Open Prometheus UI:

```
Status → Targets
```

**Expected Result:**

* `node_exporter` should show **UP**

---

## 📈 Grafana Installation & Setup

### 7️⃣ Install Required Dependencies

```bash
sudo apt install -y apt-transport-https software-properties-common wget
```

**Purpose:**
Enables secure package downloads and repository management.

---

### 8️⃣ Add Grafana GPG Key

```bash
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
```

**Purpose:**
Verifies the authenticity of Grafana packages.

---

### 9️⃣ Add Grafana Repository

```bash
sudo nano /etc/apt/sources.list.d/grafana.list
```

Add:

```
deb https://packages.grafana.com/oss/deb stable main
```

---

### 🔟 Install Grafana

```bash
sudo apt update
sudo apt install grafana -y
```

---

### 1️⃣1️⃣ Start Grafana Service

```bash
sudo systemctl enable grafana-server
sudo systemctl start grafana-server
```

---

### 1️⃣2️⃣ Access Grafana UI

```
http://localhost:3000
```

**Default Login:**

* Username: `admin`
* Password: `admin`

(Change password when prompted)

---

### 1️⃣3️⃣ Add Prometheus as Data Source

* Go to **Settings → Data Sources**
* Select **Prometheus**
* URL:

```
http://localhost:9090
```

* Save & Test

**Purpose:**
Grafana retrieves metric data from Prometheus.

---

### 1️⃣4️⃣ Create Monitoring Dashboards

**Recommended Method:** Import a prebuilt dashboard

* Go to **Dashboards → Import**
* Dashboard ID: `1860`
* Select Prometheus as data source
* Import

**Metrics Displayed:**

* CPU usage
* Memory usage
* Disk I/O
* Network activity

---

## ⏱Understanding Time-Series Metrics

Time-series data means:

* Metrics are stored with timestamps
* Values are tracked over time
* Enables trend analysis and anomaly detection

Example:

```
CPU usage at 10:00 → 25%
CPU usage at 10:01 → 70%
```

---

## Simulate System Load

### Install Stress Tool

```bash
sudo apt install stress -y
```

### Generate CPU Load

```bash
stress --cpu 2 --timeout 60
```

**Observation:**

* CPU graphs spike in Grafana
* Confirms monitoring is working correctly

---

## Monitoring Insights

* CPU usage increases immediately under load
* Memory usage remains relatively stable
* Disk metrics change only during I/O operations
* Metrics update in near real time
* Time-series graphs clearly show performance trends

---

## Conclusion

This project demonstrates:

* Real-world monitoring fundamentals
* How metrics are collected, stored, and visualized
* The importance of observability in DevOps systems

This setup closely resembles **production-grade monitoring foundations** used in cloud and DevOps environments.

---

