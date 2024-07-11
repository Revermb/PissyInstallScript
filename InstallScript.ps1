Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
$installers = Get-ChildItem "D:\Installers" -Filter "*.exe"
foreach ($inst in $installers) {
    Write-Host "----------------------------------------------"
    Write-Host "Installing $inst "
    Start-Process -FilePath $inst.FullName -Wait
}

$installers = Get-ChildItem "D:\Installers" -Filter "*.msi"
foreach ($inst in $installers) {
    Write-Host "----------------------------------------------"
    Write-Host "Installing $inst "
    Write-Host "----------------------------------------------"
    Start-Process -FilePath $inst.FullName -Wait
}