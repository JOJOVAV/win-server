function Show-Menu {
    param (

        # [xml]import-clixml 
        [string]$Title = "Choose your option"
    )
    Clear-Host
    Write-Host "================ $Title ================"
   
    Write-Host "1: Change Servername"
    Write-Host "2: Change IP"
    # Write-Host "3: "
    # Write-Host "4: "
    # Write-Host "5: "
    # Write-Host "6: "
    Write-Host "S: Stop"
}