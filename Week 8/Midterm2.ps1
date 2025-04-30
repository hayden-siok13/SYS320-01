function Parse-WebServerLogs {
   param (
       [string]$FilePath
   )


$logEntries = Get-Content $FilePath

$logPattern= '^(?<IP>\S+) - - \[(?<Time>.+?) -\d+\] "(?<Method>\S+) (?<Page>\S+) (?<Protocol>\S+)" (?<Response>\d+) \d+ "(?<Referrer>[^"]+)"'

$parsedLogs = @()

foreach ($entry in $logEntries) {
   if ($entry -match $logPattern) {
       $parsedLogs += [PSCustomObject]@{
           IP        = $matches['IP']
           Time      = $matches['Time']
           Method    = $matches['Method']
           Page      = $matches['Page']
           Protocol  = $matches['Protocol']
           Reponse   = $matches['Reponse']
           Referrer  = $matches['Referrer']
        }
     }
   }

return $parsedLogs

}

$logInfo = Parse-WebserverLogs -FilePath "C:\Users\champuser\Downloads\access.log"
$logInfo | Format-Table -AutoSize
