
---

# Day 14 — Ansible Automation with AWS EC2

## Project Overview

This project demonstrates configuration management and automation using **Ansible** with two AWS EC2 instances. The control machine runs inside **WSL (Ubuntu)** and connects securely to AWS instances using SSH.

The automation installs and configures the **Lighttpd and Nginx web server** on multiple EC2 instances using Ansible inventory, playbooks, variables, handlers, and roles.

---

## Architecture

**Control Node:** WSL Ubuntu (local machine)
**Managed Nodes:** AWS EC2 Instances (2 Ubuntu servers)
**Connection Method:** SSH key-based authentication
**Automation Tool:** Ansible

---

## Directory Structure

```
day-14/
│
├── inventory
├── package-download.yml
├── vars.yml
├── ansible-key.pem
│
└── the-role/
    ├── tasks/
    │   └── main.yml
    ├── handlers/
    │   └── main.yml
    ├── defaults/
    │   └── main.yml
    ├── vars/
    │   └── main.yml
    └── meta/
        └── main.yml
```

---

## Prerequisites

### AWS

* AWS account
* Two EC2 instances (Ubuntu 22.04)
* Security group allowing:

  * SSH (Port 22)
  * HTTP (Port 80)
* Downloaded `.pem` key pair

### Local Machine

* Windows with WSL Ubuntu
* Internet connectivity

---

## Step 1: Install Ansible on Control Machine

Update packages:

```bash
sudo apt update && sudo apt upgrade -y
```

Install Ansible:

```bash
sudo apt install ansible -y
```

Verify:

```bash
ansible --version
```

---

## Step 2: Prepare SSH Key

Copy key to WSL:

```bash
cp /mnt/c/Users/YOUR_USERNAME/Downloads/ansible-key.pem ~/
```

Set secure permission:

```bash
chmod 400 ~/ansible-key.pem
```

---

## Step 3: Verify SSH Access

```bash
ssh -i ~/ansible-key.pem ubuntu@NODE1_PUBLIC_IP
```

Repeat for Node 2.

---

## Step 4: Configure Inventory

Create inventory file:

```bash
nano inventory
```

```
[slave]
NODE1_PUBLIC_IP
NODE2_PUBLIC_IP

[slave:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/ansible-key.pem
```

Test connectivity:

```bash
ansible all -i inventory -m ping
```

Expected output:

```
pong
```

---

## Step 5: Install Nginx Using Playbook

Create playbook:

```bash
nano package-download.yml
```

```yaml
---
- name: Installing and starting nginx
  hosts: slave
  become: yes
  gather_facts: no
  vars_files:
    - vars.yml
  tasks:

    - name: updating the package
      apt:
        update_cache: yes

    - name: installing nginx
      apt:
        name: nginx
        state: latest
      notify: restart nginx

  handlers:
    - name: restart nginx
      service:
        name: nginx
        state: restarted
```

Run:

```bash
ansible-playbook -i inventory package-download.yml
```

Verify:

```
http://NODE_PUBLIC_IP
```

---

## Step 6: Using Variables

Create variables file:

```bash
nano vars.yml
```

```yaml
package_name: lighttpd
```

Update playbook:

```yaml
apt:
  name: "{{ package_name }}"
  state: present
```

---

## Step 7: Idempotency

Run playbook again:

```bash
ansible-playbook -i inventory package-download.yml
```

If nothing changes:

```
changed=0
```

This confirms the playbook is idempotent.

---

## Step 8: Create Role

Initialize role:

```bash
ansible-galaxy init the-role
```

Edit tasks:

```bash
nano the-role/tasks/main.yml
```

```yaml
---
    - name: updating the package
      apt:
        update_cache: yes

    - name: dynamic package
      apt:
        name: "{{ package_name }}"
        state: present

    - name: starting dynamic package
      service:
        name: "{{package_name}}"
        state: started

    - name: installing nginx
      apt:
        name: nginx
        state: latest

```

Create role playbook:

```bash
nano role_playbook.yml
```

```yaml
- hosts: slave
  become: yes
  roles:
    - the-role
```

Run:

```bash
ansible-playbook -i inventory role_playbook.yml
```

---

## Key Concepts Demonstrated

* Ansible control node and managed nodes
* SSH key-based authentication
* Inventory configuration
* Package installation using modules
* Playbook automation
* Variables usage
* Idempotent configuration
* Handlers for service restart
* Role-based structure

---

## Outcome

This project automates the installation and configuration of a web server across multiple AWS instances using Ansible, demonstrating real-world DevOps configuration management practices.

---