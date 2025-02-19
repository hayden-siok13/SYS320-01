. (Join-Path $PSScriptRoot "Functions&EventLogs-D4.ps1")

clear

# Get Login and Logoffs from the last 15 days
$loginoutsTable = Get-LoginLogoutEvents
$loginoutsTable


