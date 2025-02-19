# Get login and logoff records from Windows Events and save to a variable
# Get the last 14 days 
$loginouts = Get-EventLog system -source Microsoft-Windows-winlogon -After (Get-Date).AddDays(-14)

$loginoutsTable = @()
for($i=0; $i -lt $loginouts.Count; $i++){

# Creating event property value
$event = ""
if($loginouts[$i].InstanceId -eq  7001) {$event="Logon"}
if($loginouts[$i].InstanceId -eq  7002) {$event="Logoff"}

# Creating user property value
$user = $loginouts[$i].ReplacementStrings[1]

$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated;
                                       "Id" = $loginouts[$i].EventID;
                                    "Event" = $event;
                                     "User" = $user;
                                     }
} # End of for loop

$loginoutsTable