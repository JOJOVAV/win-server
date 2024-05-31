# This script is made with L<3VE by
# Joren Van Acker Voorspoels


# Set your GitHub username and repository name
$githubUsername = "your-github-username"
$repositoryName = "your-repository-name"

# Set your current version
$currentVersion = "1.0.0"

# Fetch the latest release from GitHub
$latestReleaseUrl = "https://api.github.com/repos/$githubUsername/$repositoryName/releases/latest"
$latestRelease = Invoke-RestMethod -Uri $latestReleaseUrl
$latestVersion = $latestRelease.tag_name

# Compare the latest version with the current version
if ($latestVersion -ne $currentVersion) {
    Write-Host "A new version is available: $latestVersion"

    # Download the latest release assets
    $downloadUrl = $latestRelease.assets[0].browser_download_url
    $downloadPath = ".\latest_release.zip"
    Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadPath

    # Extract the downloaded ZIP file
    Expand-Archive -Path $downloadPath -DestinationPath .\latest_release

    # Replace your existing files with the updated ones
    # ...

    # Perform any additional steps required for the update
    # ...

    # Clean up the downloaded ZIP file
    Remove-Item -Path $downloadPath
    Remove-Item -Path ".\latest_release" -Recurse
}

# $folderPath = 'C:\Users\JVAV\OneDrive - AP Hogeschool Antwerpen\ap\vakken\y1 2.0\scripting\examen_script\settings'
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

# $scriptPath = $PSScriptRoot
# $driveLetter = (Split-Path -Path $scriptPath -Qualifier).TrimEnd(":")

# if ($driveLetter -ne 'Z') {
#     $destinationPath = 'Z:\scripting'

#     #move the script to the destination folder
#     Move-Item -Path $scriptPath -Destination $destinationPath -Force
#     Move-Item -Path $scriptPath\* -Destination $destinationPath -Force

#     #update the script path
#     $scriptPath = $destinationPath
# }


# $osInfo = Get-WmiObject -Class Win32_OperatingSystem
# if ($osInfo.Caption -like "*Windows Server*") {
#     Write-Host "Running on Windows Server"
# } elseif ($osInfo.Caption -like "*Windows 10*") {
#     Write-Host "Running on Windows 10 PC"
# } else {
#     Write-Host "Unknown Operating System"
# }

function Show-Menu {
    param (
          [string]$Title = "Choose your option"
    )
    Clear-Host
    Write-Host "================ $Title ================"
   
    Write-Host "1: Check Basic Settings"
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

            # [xml]$variable = import-clixml path/to/location/file

            # $variable.properties
                Clear-Host
                $xmlFilepath = "$folderPath/instellingen.xml"
            #    [XML]$xmlString = Select-Xml -Path $xmlFilepath -XPath "//S" | ForEach-Object {$_.node.InnerXML}
                
                [xml]$xmlsettings = Get-Content -path $xmlFilepath

                # [xml]$settings = Get-Content $xmlFilepath
                # gives me the whole settings page
                # the path is Objs > Obj > MS > S

                
                $settingsWithNumbers = @{}
                foreach ($setting in $xmlsettings.Objs.Obj.MS.S) {
                    $name = $setting.N
                    $value = $setting."#text"

                    Write-Host "$counter. $name : $value"
                    $settingsWithNumbers.Add($counter, $name)
                    
                }
            #    Write-Output $settings
                # Write-Host $settings
                # Prompt the user for an option
            Write-Host "`nSelect an option:"
            Write-Host "1. Edit a setting"
            Write-Host "2. Configure the Windows server"
            Write-Host "3. Cancel and go back"

            $option = Read-Host "Enter the number of your choice"

            switch ($option) {
                1 {
                    Clear-Host
                    # Prompt the user for the setting(s) they want to edit
                    [int]$settingsToEdit = Read-Host "Enter the number of the name(s) from the setting(s) you want to edit (separated by commas)"

                    # Split the input into an array of setting names
                    $settingNames = $settingsToEdit -split ","

                    foreach ($settingName in $settingNames) {
                        $settingName = $settingName.Trim()

                        # Find the matching setting in the XML data
                        $matchingSetting = $settings | Where-Object { $_.name -eq $settingName }

                        if ($matchingSetting) {
                            # Prompt the user for the new value
                            $newValue = Read-Host "Enter the new value for $settingName"

                            # Update the setting value
                            $matchingSetting.value = $newValue

                            Write-Host "Setting '$settingName' updated to '$newValue'."
                        }
                        else {
                            Write-Host "Setting '$settingName' not found."
                        }
                    }

                    # Save the modified XML file
                    $xml_data.Save("C:\path\to\modified_file.xml")
                }
                2 {
                    # Code to configure the Windows server
                    Write-Host "Configuring the Windows server..."
                    # Perform the necessary actions to configure the Windows server
                }
                3 {
                    # Code to cancel and go back
                    Write-Host "Cancelled. Going back..."
                    # Perform the necessary actions to go back to the previous menu
                }
                default {
                    Write-Host "Invalid option. Please try again."
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
                "active directory: https://github.com/sysadmintutorials/windows-server-2019-powershell-ad-install-config"

                
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