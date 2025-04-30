# Set path to configuration text file
$ConfigPath = "C:/Users/champuser/SYS320-01/Week 7/configuration.txt"

# Prompt to print questions and take number answer
$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Show Configuration`n"
$Prompt += "2 - Change Configuration`n"
$Prompt += "3 - Exit`n"



$menu_open = $true

while($menu_open){

     Write-Host $Prompt 
     $choice = Read-Host


     if($choice -eq 3){
        Write-Host "Exiting menu, Goodbye!" 
        exit
        $menu_open = $false
     }


     elseif($choice -eq 1){
            # Read configuration file
            $configContent = Get-Content -Path $ConfigPath

            # Parse the lines of the file
            $number = $configContent[0]
            $time = $configContent[1]

            # Create a PSCustomObject with the parsed values
             $configObject = [PSCustomObject]@{
                 Days = $number
                 ExecutionTime = $time
         }
         $configObject | Format-Table -AutoSize
    }



     elseif($choice -eq 2){
           $days = Read-Host "Enter the number of days(digits only) that you wish to get logs for"
           if($days -match '^\d+$'){
              $days | Set-Content -Path $ConfigPath
        } else {
              Write-Host "Incorrect input, please enter digits only." 
        }

           $time= Read-Host "Enter execution time (h:mm AM/PM) for when the email should be sent"
           if($time -match '^\d{1,2}:\d{2}\s(AM|PM)$'){
              $time | Add-Content -Path $ConfigPath
        } else {
               Write-Host "Incorrect time format, please enter in h:mm AM/PM format." 
        }
               Write-Host "Configuration updated successfully!"
               continue
    }

    else {
         Write-Host "Option not found, please input a number from the menu."
         continue
    }

}