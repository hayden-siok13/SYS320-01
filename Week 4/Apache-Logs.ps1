function Get-ApacheLogEntries {
   param (
       [string]$logFile = "C:\xampp\apache\logs\access.log"
   )

   $pattern = '^(\\d+\\.\\d+\\.\\d+) .*?GET \\/(index\\.html|page1\\.html|page2\\.html|page3\\.html) .*?" (\\d{3}) .*?"(.*?)"'

   $entries = Select-String -Path $logFile -Pattern $pattern | ForEach-Object {
      
      $match = $_.Matches
      [PSCustomObject]@{
          IP = $match.Groups[1].Value # IP Addresses
          Page = $match.Groups[2].Value # Requested page
          HTTPCode = $match.Groups[3].Value # HTTP response code
          Browser = $match.Groups[4].Value # Browser
       }
  }

  $entries | Format-Table -Property IP, Page, HTTPCode, Browser
  # return $entries | Sort-Object IP, Page, HTTPCode, Browser -Unique
}