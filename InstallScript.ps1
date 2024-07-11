#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
Set-Location D:
$installers = Get-ChildItem ".\Installers" -Filter "*.exe"
foreach ($inst in $installers) {
    Write-Host "----------------------------------------------"
    Write-Host "Installing $inst "
    Start-Process -FilePath $inst.FullName -Wait
}

$installers = Get-ChildItem ".\Installers" -Filter "*.msi"
foreach ($inst in $installers) {
    Write-Host "----------------------------------------------"
    Write-Host "Installing $inst "
    Write-Host "----------------------------------------------"
    Start-Process -FilePath $inst.FullName -Wait
}
