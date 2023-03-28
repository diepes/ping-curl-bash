#!/bin/bash

# Set the host variable
host="${1:-www.googe.com}"  echo $result

  # Print a summary every 20 output lines
  if (( $i % 20 == 0 )); then
    average_time=$(echo "scale=3; $total_time / $requests" | bc)
    echo "Ping summary: Requests=$requests, Total time=$total_time s, Average time=$average_time s, Total bytes downloaded=$total_bytes bytes"
  fi
done

# Calculate the average time and print the final summary
average_time=$(echo "scale=3; $total_time / $requests" | bc)
echo "Final ping summary: Requests=$requests, Total time=$( echo "$total_time / 1" | bc)s, Average time=$average_time s, Total bytes downloaded=$total_bytes bytes"


# Set the number of iterations
count="${2:-1000}"

# Initialize variables to keep track of the total time, number of requests, and total bytes downloaded
total_time=0
requests=0
total_bytes=0

# Loop for the specified number of times
for (( i=1; i<=$count; i++ )); do
  # Make the request and print only the total time and size of the downloaded file
  result=$(curl -s -w 'Total: %{time_total}s, Size: %{size_download} bytes\n' -o /dev/null $host)

  # Extract the time from the result string and remove the trailing "s"
  time=$(echo $result | awk '{gsub(/s,$/, "", $2); print $2}')

  # Extract the size of the downloaded file from the result string
  bytes=$(echo $result | awk '{print $4}')

  [[ $debug ]] && echo "Debug time=$time  bytes=$bytes"
  # Add the time and bytes to their respective totals and increment the number of requests
  total_time=$(echo "$total_time + $time" | bc)
  total_bytes=$(echo "$total_bytes + $bytes" | bc)
  requests=$((requests + 1))

  # Print the result
