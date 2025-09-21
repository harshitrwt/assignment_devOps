#!/bin/bash


APP_URL="$1"
LOG_FILE="$HOME/app_health_check.log"
TIMEOUT=5


if [ -z "$APP_URL" ]; then
    echo "Usage: $0 <URL>"
    echo "Example: $0 https://example.com"
    exit 1
fi


print_separator() {
    echo "==============================================================="
}


timestamp=$(date '+%Y-%m-%d %H:%M:%S')


HTTP_RESPONSE=$(curl -o /dev/null -s -w "%{http_code}" --max-time $TIMEOUT "$APP_URL")
EXIT_CODE=$?

print_separator
echo " Application Health Check - $timestamp "
print_separator
echo "URL:           $APP_URL"
if [ $EXIT_CODE -ne 0 ]; then
    echo "Result:        ERROR - Unable to reach the application"
    echo "Curl Exit Code:$EXIT_CODE"
    echo "Status:        DOWN"
    echo
    echo "$timestamp | $APP_URL | ERROR | curl exit code: $EXIT_CODE" >> "$LOG_FILE"
else
    if [ "$HTTP_RESPONSE" -ge 200 ] && [ "$HTTP_RESPONSE" -lt 400 ]; then
        echo "HTTP Status:   $HTTP_RESPONSE (OK)"
        echo "Status:        UP"
        echo
        echo "$timestamp | $APP_URL | UP | HTTP $HTTP_RESPONSE" >> "$LOG_FILE"
    else
        echo "HTTP Status:   $HTTP_RESPONSE (ERROR)"
        echo "Status:        DOWN"
        echo
        echo "$timestamp | $APP_URL | DOWN | HTTP $HTTP_RESPONSE" >> "$LOG_FILE"
    fi
fi
print_separator
