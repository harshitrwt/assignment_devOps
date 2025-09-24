# System Healh Monitoring Script

This is a **Bash script** to monitor system health metrics, CPU usage, memory usage, disk usage, and the top 5 CPU-consuming processes. If the usage exceeds defined thresholds, it logs an alert to the terminal.

---

## Features

- Monitors:
  - CPU Usage
  - Memory Usage
  - Disk Usage
  - Top 5 CPU-consuming processes
- Alerts when thresholds are breached
- Logs alerts to both the terminal and a file: `~/system_health.log`

---

## Script File

Filename: `checker.sh`

Make it executable:

```bash
chmod +x checker.sh
```

Here's some screenshots

## Running the file normally.
<img width="1197" height="903" alt="Screenshot 2025-09-24 121617" src="https://github.com/user-attachments/assets/38a18f5a-c46a-4739-a7e9-14ad165d872b" />

## Cpu usage incresed in purpose using: do yes > /dev/null

- Alert message can be seen when cpu goes above 40, 80 any number i have set to 40 right now. 
<img width="1115" height="615" alt="Screenshot 2025-09-24 121644" src="https://github.com/user-attachments/assets/907ebd17-de52-4681-9cfa-c72d4e3e8a1c" />

## process terminated CPU back to normal

<img width="1233" height="891" alt="Screenshot 2025-09-24 121707" src="https://github.com/user-attachments/assets/ae295e6b-a842-4271-933e-dfc4fc458445" />



