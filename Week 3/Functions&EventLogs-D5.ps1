function Get-SystemStartShutDownEvents {
    # Defining the Event IDs
    $StartId = 6005
    $ShutdownId = 6006

    # Retrieve the events from the System log
    $events = Get-WinEvent -LogName System | Where-Object {$_.Id -eq $StartId -or $_.Id -eq $ShutdownId }

    # Create an array to store results
    $results = @()

    foreach ($event in $events) {
        if ($event.Id -eq $StartId) {
            $EventType = "System Start"
        } elseif ($event.Id -eq $ShutdownId) {
            $EventType = "System Shutdown"
        }

        # Creating and object for each event
        $EventObject = [PSCustomObject]@{
             Time  = $event.TimeCreated
             Id    = $event.Id
             Event = $EventType
             User  = "System"
        }

        $results += $eventObject

     }

     $results += $EventObject
}

    $SystemEvents = Get-SystemStartShutdownEvents
    $SystemEvents | Format-Table -Autosize