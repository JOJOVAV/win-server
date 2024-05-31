function Show-Menu {
    param (
          [string]$Title = "Choose your option"
    )
    Clear-Host
    Write-Host "================ $Title ================"
   
    Write-Host "1: Change domainname"
    Write-Host "2: "
    # Write-Host "3: "
    # Write-Host "4: "
    # Write-Host "5: "
    # Write-Host "6: "
    Write-Host "S: Stop"
}