# Load the XML file


# Extract the server name from the XML
$serverName = $xmlsettings.Objs.Obj.MS.S | Where-Object { $_.N -eq "servernaam" }."#text"

# Set the new server name
Rename-Computer -NewName $serverName -Force -Restart