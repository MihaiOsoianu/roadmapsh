#!/bin/bash

#top 5 IP addresses with most requests
#top 5 most requested paths
#top 5 response status codes
#top 5 user agents

echo -e "\nTop 5 IP addresses with the most requests:"
awk '{print $1}' logs | sort | uniq -c | sort -nr | head -n 5 | while read -r count ip; do
	echo "$ip - $count requests"
done

echo -e "\nTop 5 most requested paths:"
awk -F'"' '{print $2}' logs | awk '{print $2? $2 : $1}' | sort | uniq -c | sort -nr | head -n 5 | while read -r count path; do
	echo "$path - $count requests"
done

echo -e "\nTop 5 response status codes:"
grep -oP '\s\d{3}\s' logs | tr -d ' ' | sort | uniq -c | sort -nr | head -n 5 | while read -r count code; do
	echo "$code - $count requests"
done

echo -e "\nTop 5 user agents:"
awk -F'"' '{print $(NF-1)}' logs | sort | uniq -c | sort -nr | head -n 5 | while read -r count agent; do
	echo "$agent - $count requests"
done
