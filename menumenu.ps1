# This script is made with L<3VE by
# Joren Van Acker Voorspoels

# check for files in settings folder
$folderPath =  Join-Path -Path $PSScriptRoot -ChildPath "settings"
$expectedFiles = @('mappen.txt', 'instellingen.xml', 'groups.csv', 'ous.csv', 'rechten.csv', 'shares.csv', 'usergroups.csv', 'users.csv')

$missingFiles = $expectedFiles | Where-Object { -not (Test-Path (Join-Path $folderPath $_)) }

if ($missingFiles) {
    Write-Host -ForegroundColor Red "The following files are missing in the folder $folderPath : $missingFiles"

    Read-Host "Press Enter to exit..."

    exit

} else {
    Write-Host -ForegroundColor Green "All files are present in the correct folder. Make sure the data is correct before running the script."

    Read-Host "Press Enter to continue..."
}

# loading xml file in
$xmlFilepath = "$folderPath/instellingen.xml"
[xml]$xmlsettings = Get-Content -path $xmlFilepath

# menu

function Show-Menu {
    param (
          [string]$Title = "Choose your option"
    )
    Clear-Host
    Write-Host "================ $Title ================"
   
    Write-Host "1: install basic things"
    Write-Host "2: Check Domain Settings"
    Write-Host "3: Configure Server"
    Write-Host "4: credits/sources"
    # Write-Host "5: "
    # Write-Host "6: "
    Write-Host "C: Close"
}



do {
    Show-Menu
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
           '1' {
                Clear-Host
                "basic settings are
                changing servername
                changing IP's
                changing mac address
                changing DNS"

                $answer = Read-Host -Prompt "would you like to continue: [y/n]: "

                if ($answer -eq "y") {
                    Clear-Host
                    "continuing"
                    $serverName = $xmlsettings.Objs.Obj.MS.S | Where-Object { $_.N -eq "servernaam" }."#text"
                    $WIPaddress = $xmlsettings.Objs.Obj.MS.S | Where-Object { $_.N -eq "Wan_ip_dns" }."#text"
                    $LIPaddress = $xmlsettings.Objs.Obj.MS.S | Where-Object { $_.N -eq "Lan_ip_address" }."#text"
                    $subnetMaks = $xmlsettings.Objs.Obj.MS.S | Where-Object { $_.N -eq "LAN_ip_netmask" }."#text"
                    # nice
                    # Get the list of network adapters and count them
                    $networkAdapters = Get-NetAdapter
                    $numberOfAdapters = $networkAdapters.Count

                    # Check if there are two network adapters
                    if ($numberOfAdapters -eq 2) {
                    Write-Host "There are 2 network adapters on this server."
                    } else {
                    Write-Host "There are not exactly 2 network adapters on this server. Found: $numberOfAdapters"
                    }
               
               }
                
            }

           '2' {
                Clear-Host
               "Opening Domain Settings"
               "Under construction"

            }
           '3' {
                Clear-Host
                "Under construction"

            }
           '4' {
                Clear-Host
                "source: Trust me bro"
                "credits and sources:"
                "log files: https://www.reddit.com/r/PowerShell/comments/xaxthb/log_file/"
                "checking for files: taken from previous script(checking the hash of the files)"
                "xmlfiles: Danny <3"
                "xmlfiles: https://techgenix.com/reading-extracting-xml-files-with-powershell/"
                "install active directory: https://www.dell.com/support/kbdoc/en-us/000121955/installing-active-directory-domain-services-and-promoting-the-server-to-a-domain-controller"

                
           }
           '5' {
                Clear-Host
                'You chose option #5'
           }
           '6' {
                Clear-Host
                'You chose option #6'
           }
           's' {
                return
           }
     }
     pause
} 
until ($input -eq 'C' -or $input -eq 'c')
