function gatherClasses(){

$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.44/courses.html

# Get all the tr elements of the HTML document courses.html
$trs=$page.ParsedHtml.getElementsByTagName("tr")

# Empty array to hold the results
$FullTable = @()
for($i=1; $i -lt $trs.length; $i++){ # Going over every tr element

# Get every td element of current tr element
$tds = $trs[$i].getElementsByTagName("td")

# Want to seperate start time and end time from one time field
$Times = $tds[5].innerText.Split("-")

$FullTable += [PSCustomObject]@{"Class Code"  = $tds[0].innerText; `
                          "Title"      = $tds[1].innerText; `
                          "Days"       = $tds[4].innerText; `
                          "Time Start" = $Times[0]; `
                          "Time End"   = $Times[1]; `
                          "Instructor" = $tds[6].innerText; `
                          "Location"   = $tds[9].innerText; `
                    }
} # End of for loop
return $FullTable
}



function daysTranslator($FullTable){

# Go over every record in the table
for($i=0; $i -lt $FullTable.length; $i++){
   # Empty array to hold days for every record
   $Days = @()

   # If you see "M" -> Monday
   if($FullTable[$i].Days -ilike "*M*"){ $Days += "Monday" }

   # If you see "T" followed by T,W or F -> Tuesday
   if($FullTable[$i].Days -ilike "*T[^H]*"){ $Days += "Tuesday" }
   # If you only see "T" -> Tuesday
   ElseIf($FullTable[$i].Days -ilike "T"){ $Days += "Tuesday" }

   # If you see "W" -> Wednesday
   if($FullTable[$i].Days -ilike "*W*"){ $Days += "Wednesday" }

   # If you see "TH" -> Thursday
   if($FullTable[$i].Days -ilike "*TH*"){ $Days += "Thursday" }

   # F -> Friday
   if($FullTable[$i].Days -ilike "*F*"){ $Days += "Friday" }

   # Make the switch from single letter to day name
   $FullTable[$i].Days = $Days
}

return $FullTable
}


$FullTable = gatherClasses
$FullTable = daysTranslator $FullTable


# List all the classes of Instructor Furkan Paligu. Uncomment below to use
# $FullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" `
#            |  Where-Object { $_."Instructor" -eq "Furkan Paligu" }


# List all the classes of JOYC 310 on Mondays, only display Class Code and Times
# Sort by Start Time
# Uncomment code below get results defined above
# $FullTable | Where-Object { ($_.Location -eq "JOYC 310") -and ($_.days -contains "Monday") } | `
#             Select-Object "Time Start", "Time End", "Class Code" | `
#             Format-Table "Time Start", "Time End", "Class Code"


# Make a list of all the instructors that teach at least 1 course in SYS, SEC, NET, FOR, CSI, DAT
# Sort by name, and make it unique
$ITSInstructors = $FullTable | Where-Object { ($_."Class Code" -like "SYS*") -or `
                                              ($_."Class Code" -like "NET*") -or `
                                              ($_."Class Code" -like "SEC*") -or `
                                              ($_."Class Code" -like "FOR*") -or `
                                              ($_."Class Code" -like "CSI*") -or `
                                              ($_."Class Code" -like "DAT*") } `
                             | Select-Object "Instructor" -Unique `
                             | Sort-Object "Instructor" `
                            # | Format-Table "Instructor" -AutoSize



# Group all the instructors by the number of classes they are teaching
$FullTable | Where-Object { $_.Instructor -in $ITSInstructors.Instructor } `
           | Group-Object "Instructor" | Select-Object Count,Name | Sort-Object Count -Descending

$FullTable
