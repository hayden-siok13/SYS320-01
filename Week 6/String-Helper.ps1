<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}


function checkPassword {
   param(
       [string]$Password
   )

   # Checks password length
   if ($Password.Length -lt 6) {
       return $false
   }

   # Checks for at least one letter (A_Z or a-z)
   if ($Password -notmatch '[A-Za-z]') {
       return $false
   }

   # Checks for at least one number (0-9)
   if ($Password -notmatch '\d') {
       return $false
   }
   
   # Checks for at least one special character (anything not a letter, number, or underscore)
   if ($Password -notmatch '[^\w]') {
       return $false
   }

   # If all conditions are met, return true
   return $true 
}

