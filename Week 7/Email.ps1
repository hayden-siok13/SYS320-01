function SendAlertEmail($Body){

$From = "hayden.siok@mymail.champlain.edu"
$To = "hayden.siok@mymail.champlain.edu"
$Subject = "Suspicious Activity"

$Password = "agsy tfue pyew dygv" | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" `
                 -Port 587 -UseSsl -Credential $Credential
}

SendAlertEmail "Body of email"