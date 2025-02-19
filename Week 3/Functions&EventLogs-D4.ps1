function Get-LoginLogoutEvents {
    param (
        [int]$DaysBack # This will be used to search the inputted number of days into the past
    )

    #Define what log will be and the event source
    $Log = "System"
    $EventSource = "Microsoft-Windows-winlogon"

    # Get event logs based on the input parameter
    $loginouts = Get-EventLog -LogName $Log -Source $EventSource -After (Get-Date).AddDays(-$DaysBack)

    # Initialize an array to store the results
    $EventLogsTable = @()

    # Process each event log entry
    for ($i = 0; $i -lt $loginouts.Count; $i++) {
        $event = ""
        if ($loginouts[$i].InstanceId -eq 7001) { $event = "Logon" }
        if ($loginouts[$i].InstanceId -eq 7002) { $event = "Logoff" }

        $userSid = $loginouts[$i].ReplacementStrings[1]


        # Convert SID to username for table results
        try {
            $username = ([System.Security.Principal.SecurityIdentifier]($userSid)).Translate([System.Security.Principal.NTAccount]).Value
        } catch {
            $username = $userSid
        }


        $output = [pscustomobject]@{
            "Time"  = $loginouts[$i].TimeGenerated;
            "Id"    = $loginouts[$i].InstanceId;
            "Event" = $event;
            "User"  = $username;
        }

        $loginoutsTable += $output
    }

    return $loginoutsTable
}

$days = Read-Host "Enter the number of days into the past you wish to retrieve logs for"
$results = Get-LoginLogoutEvents -DaysBack $days

$results | Format-Table -AutoSize

