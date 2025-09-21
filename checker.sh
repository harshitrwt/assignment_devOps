#!/bin/bash

CPU_THRESHOLD=5
MEMORY_THRESHOLD=5
DISK_THRESHOLD=5

LOG_FILE="/var/log/system_health.log"


check_cpu_usage() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    echo "CPU Usage: $CPU_USAGE%"

    if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
        echo "CPU usage exceeds threshold ($CPU_THRESHOLD%) at $(date)" >> $LOG_FILE
        echo "CPU usage alert: $CPU_USAGE%"
    fi
}

check_memory_usage() {
    MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    echo "Memory Usage: $MEMORY_USAGE%"

    if (( $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l) )); then
        echo "Memory usage exceeds threshold ($MEMORY_THRESHOLD%) at $(date)" >> $LOG_FILE
        echo "Memory usage alert: $MEMORY_USAGE%"
    fi
}


check_disk_usage() {
    DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
    echo "Disk Usage: $DISK_USAGE%"

    if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
        echo "Disk usage exceeds threshold ($DISK_THRESHOLD%) at $(date)" >> $LOG_FILE
        echo "Disk usage alert: $DISK_USAGE%"
    fi
}


check_running_processes() {
    echo "Top 5 CPU consuming processes:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
}


echo "System Health Check Started at $(date)" >> $LOG_FILE
check_cpu_usage
check_memory_usage
check_disk_usage
check_running_processes
echo "System Health Check Completed at $(date)" >> $LOG_FILE