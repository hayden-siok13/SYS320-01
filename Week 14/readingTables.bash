#!/bin/bash

# URL to scrape
URL="http://10.0.17.6/Assignment.html"

# Fetch the webpage
html=$(curl -s "$URL")

# Extract each column into seperate variables 
ids=$(echo "$html" | grep -o '<td>[0-9]\+</td>' | sed 's/<td>\(.*\)</td>/\1/g')
scores=$(echo "$html" | grep -o '<td>[0-9]\{2\}</td>' | sed 's/<td>(.*\)<\td>/\1/g')
dates=$(echo "$html" | grep -o '<td>[0-9]\+/[0-9]\+/[0-9]\+.*</td>' | sed 's/<td>\(.*\)<\/td>/\1/g')

# Count the number of lines in the variable ids
line_count=$(echo "$ids" | wc -l)


# Loop through each line and print the values
for ((i=1; i<=$line_count; i++))
do
    id=$(echo "$ids" | head -n $i | tail -n 1)
    score=$(echo "$scores" | head -n $i | tail -n 1)
    date=$(echo "$dates" | head -n $i | tail -n 1)




    echo "$id $score $date"
done


exit 0
