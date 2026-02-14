
---

# DevOps Task Day 12 — AWS Account Setup & EC2 CLI Access

## Overview

This task demonstrates secure AWS account preparation and launching an EC2 instance that can be accessed through the command line. It follows AWS best practices by setting a cost budget, using an IAM user instead of the root account, updating AWS CLI, and securely connecting to an EC2 instance using SSH.

---

## Objectives

* Prevent unexpected AWS charges using Budging alerts
* Follow security best practices using IAM instead of root
* Update and configure AWS CLI
* Launch an EC2 instance
* Access EC2 securely via CLI (SSH)

---

## Prerequisites

* AWS account created
* Linux system or WSL terminal
* Internet connectivity
* AWS CLI installed (will be updated)

---

## Step 1: Create AWS Budget (Cost Protection)

### Purpose

To prevent unexpected charges by receiving alerts when spending reaches a defined limit.

### Steps

1. Login to AWS Console as root user.
2. Open **Billing Dashboard**.
3. Navigate to **Budgets → Create budget**.
4. Select:

   * Budget type: **Cost budget**
   * Period: **Monthly**
   * Budget amount: **$5**
5. Configure alerts:

   * 80% threshold
   * 100% threshold
6. Save the budget.

---

## Step 2: Create IAM Admin User (Security Best Practice)

### Purpose

Avoid using the root account for daily operations.

### Steps

1. Open **IAM Dashboard**.
2. Navigate to **Users → Create user**.
3. Username: `devops-user`
4. Enable console access (optional).
5. Attach permission policy:

   * `AdministratorAccess`
6. Create user and download **Access Key ID** and **Secret Access Key**.

---

## Step 3: Secure Root Account

### Purpose

Protect the root account from unauthorized access.

### Actions

* Enable Multi-Factor Authentication (MFA).
* Avoid using root for daily tasks.

---

## Step 4: Update AWS CLI to Latest Version

### Check Version

```bash
aws --version
```

### Remove Old Version

```bash
sudo rm -rf /usr/local/aws
sudo rm -f /usr/local/bin/aws
```

### Install AWS CLI v2

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

### Verify Installation

```bash
aws --version
```

---

## Step 5: Configure AWS CLI

### Purpose

Connect local CLI with AWS account.

```bash
aws configure
```

Enter:

```
AWS Access Key ID: <IAM Access Key>
AWS Secret Access Key: <IAM Secret Key>
Default region name: ap-south-1
Default output format: json
```

### Verify Connection

```bash
aws sts get-caller-identity
```

---

## Step 6: Launch EC2 Instance

### Purpose

Create a cloud-based virtual server.

### Configuration

**Name:** devops-day12-ec2
**AMI:** Amazon Linux 2023
**Instance type:** t2.micro (Free Tier eligible)

---

## Step 7: Create Key Pair

### Purpose

Secure SSH access to the EC2 instance.

**Key Pair Settings:**

* Name: `devops-key`
* Type: RSA
* Format: `.pem`

Store the downloaded key securely.

---

## Step 8: Configure Security Group

### Purpose

Allow secure remote access.

**Inbound Rule:**

| Type | Protocol | Port | Source |
| ---- | -------- | ---- | ------ |
| SSH  | TCP      | 22   | My IP  |

---

## Step 9: Connect to EC2 via CLI

### Move Key to Secure Location

```bash
mv devops-key.pem ~/.ssh/
chmod 400 ~/.ssh/devops-key.pem
```

### Connect Using SSH

```bash
ssh -i ~/.ssh/devops-key.pem ec2-user@<PUBLIC-IP>
```

---

## Verification

Successful connection will display:

```
[ec2-user@ip-xxx-xxx-xxx ~]$
```

---

## Best Practices Followed

* Cost monitoring using AWS Budgets
* Root account secured with MFA
* IAM user used for daily operations
* Principle of least privilege (admin role for lab)
* SSH access restricted to local IP
* Secure key permissions applied

---

## Cleanup Recommendation

To avoid charges:

* Stop instance when not in use:

```bash
aws ec2 stop-instances --instance-ids <instance-id>
```

* Terminate instance when finished.

---

## Outcome

This task successfully demonstrates:

* Secure AWS account setup
* CLI integration with AWS
* EC2 provisioning
* Secure remote server access

---

