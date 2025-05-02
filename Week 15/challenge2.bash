#!/bin/bash

logFile="access.log"
iocFile="ioc.txt"
results=$(cat "$logFile" | egrep -i -f "$iocFile" | cut -d ' ' -f 4,1,7 | tr -d '[')
echo "$results" >> report.txt
cat "report.txt" | sort -n | uniq
