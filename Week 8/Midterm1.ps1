# Path to the IOC file
$path = "C:\Users\champuser\Downloads\IOC.html"

# Get-content to read the html of the file
$html = Get-Content $path -Raw

# Regex to extract table rows
$matches = [regex]::Matches($html, "<tr>\s*<td>(.*?)</td>\s*<td>(.*?)</td>\s*</tr>")

# Initializes an array
$ioc = @()


foreach ($match in $matches) {
   $ioc += [PSCustomobject]@{
       Pattern     = $match.Groups[1].Value
       Explanation = $match.Groups[2].Value
       }
}

$ioc