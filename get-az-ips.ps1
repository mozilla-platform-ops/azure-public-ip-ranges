<#
Microsoft does not provide a list to json file with the Azure IP ranges. 
The only way to get the list is to parse the HTML of a page that contains the link to the json file.

Stackoverflow link: https://stackoverflow.com/questions/76248035/download-azure-ip-list-and-extract-values-for-specific-service-name

This script will parse that page for the json file and then post it to github

#>

## Vars
$AzurePublicIpRanges = "https://www.microsoft.com/en-us/download/confirmation.aspx?id=56519"
## Get the response
$Response = Invoke-WebRequest -Uri $AzurePublicIpRanges
## Get all of the json links in the href tags and select the unique one since for some reason the page publishes several
$json_url = $Response.links.href | Sort-Object | Where-Object {$_ -match "json"} | Select-Object -Unique
## Now that we have the link, extract the file
Invoke-WebRequest -Uri $json_url -OutFile "az_ips.json"