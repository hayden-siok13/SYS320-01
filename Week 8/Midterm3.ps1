. "C:\Users\champuser\SYS320-01\Week 8\Midterm1.ps1"
. "C:\Users\champuser\SYS320-01\Week 8\Midterm2.ps1"


function SuspiciousLogs {

   param ( 
       $Logs,
       $Indicators
   )

   $suspiciousLogs = @()

   foreach ($log in $Logs) {
      
      foreach ($indicator in $Indicators) {
         
         if ($log.Page -match $indicator.Pattern) {

            $suspiciousLogs += $log

            break
        }
    }
  }

  return $suspiciousLogs
}

$suspiciousEntires = SuspiciousLogs -Logs $logInfo -Indicators $ioc

$suspiciousEntires | Format-Table -AutoSize