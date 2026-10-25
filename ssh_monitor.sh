#!/bin/bash

LOG="/var/log/auth.log"
REPORT_DIR="$HOME/Projects/ssh-monitor/reports"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
REPORT_FILE="$REPORT_DIR/ssh_report_$TIMESTAMP.txt"

mkdir -p "$REPORT_DIR"

TOTAL_FAILED=$(sudo grep "Failed password for invalid user" "$LOG" | wc -l)

{
echo "================================"
echo " SSH INTRUSION MONITOR REPORT"
echo " Generated: $(date)"
echo "================================"
echo
echo "Total Failed SSH Attempts: $TOTAL_FAILED"
echo
echo "Top Source IPs:"
echo "----------------"
sudo grep "Failed password for invalid user" "$LOG" | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr
echo
echo "Raw Failed Login Events:"
echo "------------------------"
sudo grep "Failed password for invalid user" "$LOG"
echo
echo "Report saved to: $REPORT_FILE"
} | tee "$REPORT_FILE"
