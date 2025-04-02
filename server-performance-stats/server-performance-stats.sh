#!/bin/bash

echo "#######################"
echo "# System General Info #"
echo "#######################"

echo "Linux Version: $(grep '^PRETTY_NAME' /etc/os-release | cut -d= -f2 | tr -d '"')"
echo "Server uptime is:$(uptime | awk -F, '{print $1}' | sed 's/^.*up //')"
echo "Currently there are$(uptime | awk -F, '{print $2}') logged in."
echo "The average load is:$(uptime | awk -F: '{print $NF}')"
echo

echo "###################"
echo "# Total CPU Usage #"
echo "###################"
echo "$(top -bn1 | grep "Cpu(s)" | cut -d ',' -f 4 | awk '{print "CPU Utilization is: " 100-$1 "%"}')"
echo

echo "######################"
echo "# Total Memory Usage #"
echo "######################"
echo "$(free | grep "Mem" | awk '{printf "Total: %.2f GiB", $2/1024^2}')"
echo "$(free | grep "Mem" | awk '{printf "Used: %.2f GiB (%.2f%%)", $3/1024^2, $3/$2*100}')"
echo "$(free | grep "Mem" | awk '{printf "Free: %.2f GiB (%.2f%%)", $4/1024^2, $4/$2*100}')"
echo

echo "######################"
echo "#  Total Disk Usage  #"
echo "######################"
echo "$(df | grep "/" -w | awk '{printf "Total: %.2f", $2/1024^2}')"
echo "$(df | grep "/" -w | awk '{printf "Used: %.2f GiB (%.2f%%)", $3/1024^2, $3/$2*100}')"
echo "$(df | grep "/" -w | awk '{printf "Available: %.2f GiB (%.2f%%)", $4/1024^2, $4/$2*100}')"
echo

echo "#######################"
echo "# Top 5 Processes MEM #"
echo "#######################"
echo "$(ps aux --sort=-%mem | head -n 6 | awk '{print $1 "\t" $2 "\t" $4 "\t" $11}')"
echo

echo "#######################"
echo "# Top 5 Processes CPU #"
echo "#######################"
echo "$(ps aux --sort=-%cpu | head -n 6 | awk '{print $1 "\t" $2 "\t" $3 "\t" $11}')"
echo
