# Wrtie a PowerShell script that lists every process for which ProcessName starts with 'C'.
# Get-process | Where-Object {$_.ProcessName -like 'C*' } 
# Write a PowerShell script that lists every process for which the path does not incluide the string "system32".
# Get-Process | Where-Object {$_.Path -notlike "*system32*"}
# Write a PowerShell script that lists every stopped service, orders it alphabetically, and saves it to a cvs file.
# Get-Service | Where-Object { $_.Status -eq 'Stopped' } | Sort-Object Name | Export-Csv -Path "StoppedServices.csv" -NoTypeInformation
# Write a PowerShell script that if an instance is not running already, it starts Google Chrome web browser and directs it to Champlain.edu. If an instance is already running it stops it.
$chromeProcess = Get-Process -Name "chrome" -ErrorAction SilentlyContinue
if (-not $chromeProcess) {
    Start-Process "chrome.exe" -ArgumentList "https://www.champlain.edu"
} else {
    Stop-Process -Name "chrome" -Force
}