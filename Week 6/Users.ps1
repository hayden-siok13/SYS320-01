

<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for enabled users
****************************** #>
function getEnabledUsers(){

  $enabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "True" } | Select-Object Name, SID
  return $enabledUsers

}



<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for not enabled users
****************************** #>
function getNotEnabledUsers(){

  $notEnabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "False" } | Select-Object Name, SID
  return $notEnabledUsers

}




<# ******************************
# Create a function that adds a user
****************************** #>
function createAUser($name, $password){

   $params = @{
     Name = $name
     Password = $password
   }

   $newUser = New-LocalUser @params -Disabled
   Add-LocalGroupMember -Group Users -Member $name


   # ***** Policies ******

   # User should be forced to change password
   #Set-LocalUser $newUser -PasswordNeverExpires $false

   # First time created users should be disabled
   #Disable-LocalUser $newUser

}



function removeAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Remove-LocalUser $userToBeDeleted
   
}



function disableAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Disable-LocalUser $userToBeDeleted
   
}


function enableAUser($name){
   
   $userToBeEnabled = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Enable-LocalUser $userToBeEnabled
   
}


function checkUser {
   param(
       [string]$Username
   )
   try {
       # Attempts to get the user. If the user doesn't exist, an error is thrown.
       $user = Get-LocalUser -Name $Username -ErrorAction Stop

       # If we get tp here without an error, the user exists.
       return $true
   }
   catch {
         # If an error happened (user not found), we catch it and return $false.
         return $false
   }
}

# checkUser function using if-else instead of try/catch
#Uncomment if you want to use if/else for checkUser and comment out the checkUser function above

#function checkUser {
#   param(
#       [string]$Username
#   )

   #Get the user (returns nohting if not found)
#   $user = Get-LocalUser | Where-Object { $_.Name -eq $Username }

#   if ($null -ne $user) {
#       return $true
#   } else {
#       return $false
#   }
#}