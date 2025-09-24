#!/bin/bash

# Define threshold values
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=30


LOG_FILE="$HOME/system_health.log"

# Function to log to both console and file
log_alert() {
    echo "$1"
    echo "$1" >> "$LOG_FILE"
}

# to check CPU 
check_cpu_usage() {
    echo -e "\n=== Checking CPU Usage ==="
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk -F'id,' -v prefix="$(date): " \
        '{ split($1, vs, ","); v=vs[length(vs)]; sub("%", "", v); print 100 - v }')

    echo "CPU Usage: $CPU_USAGE%"

    if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
        log_alert "ALERT: CPU usage is high ($CPU_USAGE%) at $(date)"
    fi
}

# to check memory 
check_memory_usage() {
    echo -e "\n=== Checking Memory Usage ==="
    MEMORY_USAGE=$(free | awk '/Mem/ { printf("%.2f", $3/$2 * 100.0) }')

    echo "Memory Usage: $MEMORY_USAGE%"

    if (( $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l) )); then
        log_alert "ALERT: Memory usage is high ($MEMORY_USAGE%) at $(date)"
    fi
}

# to check disk usage
check_disk_usage() {
    echo -e "\n=== Checking Disk Usage ==="
    DISK_USAGE=$(df / | awk 'NR==2 {gsub("%",""); print $5}')

    echo "Disk Usage: $DISK_USAGE%"

    if (( DISK_USAGE > DISK_THRESHOLD )); then
        log_alert "ALERT: Disk usage is high ($DISK_USAGE%) at $(date)"
    fi
}

# to check top 5 process
check_running_processes() {
    echo -e "\n=== Top 5 CPU-Consuming Processes ==="
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
}

# all checks with time
echo -e "\n========== System Health Check Started at $(date) ==========" | tee -a "$LOG_FILE"

check_cpu_usage
check_memory_usage
check_disk_usage
check_running_processes

echo -e "\n========== System Health Check Completed at $(date) ==========" | tee -a "$LOG_FILE"
