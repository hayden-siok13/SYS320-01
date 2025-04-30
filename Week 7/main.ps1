. "C:\Users\champuser\SYS320-01\Week 6\Event-Logs.ps1"
. "C:\Users\champuser\SYS320-01\Week 7\Configuration.ps1"
. "C:\Users\champuser\SYS320-01\Week 7\Email.ps1"
. "C:\Users\champuser\SYS320-01\Week 7\Scheduler.ps1"

# Obtaining configuration
$configuration = $configObject

# Obtaining at risk users
$Failed = atRiskUsers 

# Sending at risk users as email
SendAlertEmail ($Failed | Format-Table | Out-String)

# Setting the script to be run daily
ChooseTimeToRun($

#Code above is not finished