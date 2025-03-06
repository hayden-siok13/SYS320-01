# Get only logs that contain 404, save into $notfounds
$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '

#Define a regex for IP addresses
$regex = [regex] "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b"

# Get $notfounds records that match to the regex
$ipsUnorganized = $regex.Matches($notfounds)

#Get ips as pscustomobject
$ips = @()
for($i=0; $i -lt $ipsUnorganized.count; $i++){
 $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value;}
 }
 $ips | Where-Object {$_.IP -ilike "10.*" }