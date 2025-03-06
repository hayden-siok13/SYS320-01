Function ParsingLogs {

$logsNotformatted = Get-Content "C:\xampp\apache\logs\access.log"
$Records = @()
 

# Loop to go through each log entry
for ($i = 0; $i -lt $logsNotformatted.Count; $i++) {
     # Split log entry into words
     $words = $logsNotformatted[$i].Split(" ");

     # Custom Object for each log entry
     $Records += [pscustomobject]@{
        "IP"          = $words[0]
        "Time"        = $words[3].Trim('[')
        "Method"      = $words[5].Trim('"')
        "Page"        = $words[6]
        "Protocol"    = $words[7]
        "Response"    = $words[8]
        "Referrer"    = $words[10]
        "Client"      = $words[11..($words.Count -1)] -join " "
    }
 }

 
 

 # Return records where IP starts with 10.
 return $Records | Where-Object { $_.IP -like "10.*" }
}

# Call the fucntion and store results
$Records = ParsingLogs
# Display the results in a table format
$Records | Format-Table -AutoSize -Wrap
