#!/bin/bash

file="report.txt"

report=$(cat "$file")

echo "<html>" >> report.html
echo "<body>" >> report.html
echo "<table>" >> report.html
echo "<table style='border-collapse: collapse: width: 100%;'>" >> report.html
echo "$report" | while read -r line;
do
        echo "<tr style='border: 1px solid black'>" >> "report.html"
        echo "<td style='border: 1px solid black'>" >> "report.html"
        ip=$(echo "$line" | cut -d " " -f 1)
        date=$(echo "$line" | cut -d " " -f 2)
        page=$(echo "$line" | cut -d " " -f 3)
        echo "<tr>" >> report.html
        echo "<td> $ip </td>" >> report.html
        echo "<td> $date </td>"  >> report.html
        echo "<td> $page </td>" >> report.html
        echo "</td style='border: 1px solid black'>" >> "report.html"
        echo "</tr>" >> report.html


        echo "</tr style='border: 1px solid black'>" >> "report.html"
done

echo "</table>" >> report.html
echo "</body>" >> report.html
echo "</html>" >> report.html

mv report.html /var/www/html
