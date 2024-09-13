#!/bin/bash
#===========================
# Auto set the thread number based on CPU thread number
# and the current 5min load 
#===========================

# Get total number of CPU threads
TOTAL_THREADS=$(nproc)

# Get the 5-minute load average
LOAD_AVG=$(uptime | awk '{print $10}' | sed 's/,//')

# Calculate THREAD_NUM by subtracting the 5-minute load from total threads
THREAD_NUM=$(echo "$TOTAL_THREADS - $LOAD_AVG" | bc)

# Ensure THREAD_NUM is floored
THREAD_NUM=$(echo "$THREAD_NUM/1" | bc)

# If the result is less than 1, set THREAD_NUM to 1 to avoid any issues
if (( THREAD_NUM < 1 )); then
  THREAD_NUM=1
fi

# Export THREAD_NUM as environment variable
export THREAD_NUM

date
echo "Total CPU threads: $TOTAL_THREADS"
echo "5-minute load average: $LOAD_AVG"
echo "Threads assigned set: $THREAD_NUM"
