#!/bin/bash
# Script Name: system_info.sh
# Purpose: Print system information
# Author: Bijehn
# Date: 25-01-2026

echo "Hostname: $(hostname)"
echo "User: $(whoami)"
echo "Current Date: $(date)"
echo "uptime:"
uptime
echo "Disk Usage:"
df -h
echo "Memory Usage:"
free -h

