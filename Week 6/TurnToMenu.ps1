# Importing Functions
. "C:\Users\champuser\SYS320-01\Week 4\ParsingLogs.ps1"
. "C:\Users\champuser\SYS320-01\Week 6\Users.ps1"
. "C:\Users\champuser\SYS320-01\Week 6\Event-Logs.ps1"

clear



$Prompt = "`n"
$Prompt += "Please choose your operation`n"
$Prompt += "1 - Display the last 10 Apache Logs`n"
$Prompt += "2 - Display the last 10 failed logins for all users`n"
$Prompt += "3 - Display at Risk Users`n"
$Prompt += "4 - Start/Stop Champlain.edu Chrome Tab`n"
$Prompt += "5 - Exit`n"



$menu_open = $true

while($menu_open){


      Write-Host $Prompt | Out-String
      $choice = Read-Host


      # Exit menu choice
      if($choice -eq 5){
          Write-Host "Exiting menu, Goodbye!" | Out-String
          exit
          $menu_open = $false
      }

      # Display The Last 10 Apache Logs
      elseif($choice -eq 1){
            $ApacheLogs = ParsingLogs
            Write-Host ($ApacheLogs[-10..-1] | Format-Table -Autosize -Wrap | Out-String)
            continue
      }


      # Display the last 10 failed logins for all users
      elseif($choice -eq 2){
            $Days = Read-Host -Prompt "Please enter the number of days you wish to check for failed user logins"
            $FailedLogins = getFailedLogins($Days)

            Write-Host "Here are the results for the failed logins:"
            Write-Host ($FailedLogins | Select -Last 10 | Format-Table | Out-String)
            continue
      }


      # Display at risk users
      elseif($choice -eq 3){
            $days = Read-Host -Prompt "Please enter the number of days you wish to check for 'At Risk Users'"
            $usersAtRisk = getFailedLogins($days)
            Write-Host "The following user(s) have more than 10 unsuccessful login attempts within the past $days days and may be at risk:"
            Write-Host ($usersAtRisk | Group-Object -Property user | Where-Object {$_.count -ge 10} | Format-Table -Property count, name | out-string)
            continue
      }

      #Start/Stop Champlain.edu Chrome Tab
      elseif($choice -eq 4){
            . 'C:\Users\champuser\SYS320-01\Week 2\Process Managment 1.ps1'
            continue
      }

      # For all invalid inputs
      else{
            Write-Host "Input not found, please input a number from the menu list."
            continue
      }

}