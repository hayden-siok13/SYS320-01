#!/bin/bash

site="10.0.17.6/IOC.html"

iocFile="ioc.txt"

Page=$(curl -sl "$site")

output=$(echo "$Page" | \
xmlstarlet format --html --recover 2>/dev/nell | \
xmlstarlet select --template --value-of \
"//table//tr//td" | awk 'NR % 2 ==1' > ioc.txt)
