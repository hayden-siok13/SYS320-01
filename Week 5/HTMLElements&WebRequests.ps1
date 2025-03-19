$scraped_page = Invoke-WebRequest -URI http://10.0.17.44/ToBeScraped.html

# Get a count of the links in the page
# $scraped_page.Links.Count

#Display links as HTML Element
# $scraped_page.Links


# Display only URL and its text
# $scraped_page.Links | ForEach-Object { "outerText : $($_.outerText)`nhref : $($_.href)`n" }


#Get the outer text of every element with the tag h2
# $h2s=$scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select-Object -Property outerText

# $h2s


#Print innText of every div element that has the class as "div-1"
$divs1=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | where { $_.getAttributeNode("class").value -ilike "*div-1*"} | select innerText

$divs1