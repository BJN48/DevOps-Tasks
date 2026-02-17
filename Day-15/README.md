# DevOps Task Day 15 – Kubernetes Basics with Minikube

## Overview

This exercise demonstrates how to set up a local Kubernetes environment using **Minikube** and **kubectl**, deploy an Nginx Pod, inspect its lifecycle, access the container internally, and recreate resources using declarative configuration.

The objective is to understand core Kubernetes concepts such as clusters, nodes, pods, and reproducibility using YAML manifests.

---

## Tools Used

### Minikube

Minikube runs a single-node Kubernetes cluster locally for development and learning.

**Purpose**

* Creates a local Kubernetes environment
* Simulates a production cluster on a personal machine

---

### kubectl

kubectl is the command-line interface used to communicate with the Kubernetes control plane.

**Purpose**

* Deploy applications
* Inspect and manage cluster resources
* Debug workloads

---

### Docker (Driver)

Docker provides the container runtime used by Minikube to run Kubernetes components.

**Purpose**

* Runs containers inside pods
* Provides virtualization support for Minikube

---

## Installation and Validation

### Verify Docker Installation

```bash
docker --version
```

Confirms Docker runtime availability.

---

### Install kubectl

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

Verify:

```bash
kubectl version --client
```

**Use:** Enables communication with Kubernetes clusters.

---

### Install Minikube

```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

Verify:

```bash
minikube version
```

**Use:** Creates and manages a local Kubernetes cluster.

---

## Starting the Kubernetes Cluster

```bash
minikube start --driver=docker
```

**What this does**

* Creates a local Kubernetes node
* Starts the control plane components
* Configures kubectl automatically

Check status:

```bash
minikube status
```

---

## Exploring the Cluster

### View cluster information

```bash
kubectl cluster-info
```

Displays control plane endpoints and core services.

### Verify nodes

```bash
kubectl get nodes
```

Shows node readiness and cluster health.

---

## Pod Deployment Using YAML

### Create Pod Definition

Create `pod.yml`:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: web
spec:
  containers:
  - name: nginx-container
    image: nginx
    ports:
    - containerPort: 80
```

### YAML Field Explanation

| Field         | Purpose                            |
| ------------- | ---------------------------------- |
| apiVersion    | Kubernetes API version             |
| kind          | Resource type (Pod)                |
| metadata.name | Unique name of the pod             |
| labels        | Key-value identifiers for grouping |
| containers    | Defines containers inside the pod  |
| image         | Container image to run             |
| containerPort | Port exposed by the container      |

---

## Creating the Pod

```bash
kubectl apply -f pod.yml
```

**Use:** Creates resources declaratively from YAML.

Verify:

```bash
kubectl get pods
```

---

## Inspecting Pod Lifecycle

### Detailed pod information

```bash
kubectl get pods -o wide
```

Displays pod IP, node placement, and status.

### Describe pod events

```bash
kubectl describe pod nginx-pod
```

Shows scheduling details, container state, and event logs.

---

## Accessing the Pod Internally

### Execute shell inside container

```bash
kubectl exec -it nginx-pod -- /bin/sh
```

### Verify nginx content

```bash
ls /usr/share/nginx/html
```

### Test nginx locally

```bash
wget -qO- localhost
```

**Use:** Confirms container functionality and internal connectivity.

Exit container:

```bash
exit
```

---

## Deleting the Pod

```bash
kubectl delete pod nginx-pod
```

**Use:** Removes the running pod and frees resources.

Verify removal:

```bash
kubectl get pods
```

---

## Recreating the Pod

```bash
kubectl apply -f pod.yml
```

**Purpose**

* Demonstrates reproducibility
* Ensures consistent deployments using configuration files

---

## Key Concepts Learned

* Setting up a local Kubernetes cluster
* Understanding cluster and node readiness
* Creating pods using declarative YAML
* Inspecting pod lifecycle and events
* Accessing containers for debugging
* Recreating infrastructure for consistency

---

## Troubleshooting

If Minikube fails to start:

```bash
minikube delete
minikube start --driver=docker
```

This resets the cluster and resolves common configuration issues.

---

## Conclusion

This task introduces foundational Kubernetes operations and demonstrates how declarative configuration ensures repeatable and manageable deployments. These concepts form the basis for container orchestration in modern DevOps workflows.

---
