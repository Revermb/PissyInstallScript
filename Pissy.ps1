#Prerequisites Check
#Requires -RunAsAdministrator
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
Set-Location D:

#Getting all exe's installed
$installers = Get-ChildItem ".\Installers" -Filter "*.exe"
foreach ($inst in $installers) {
    Write-Host "----------------------------------------------"
    Write-Host "Installing $inst "
    Start-Process -FilePath $inst.FullName -Wait
}

#Getting all msi's installed
$installers = Get-ChildItem ".\Installers" -Filter "*.msi"
foreach ($inst in $installers) {
    Write-Host "----------------------------------------------"
    Write-Host "Installing $inst "
    Start-Process -FilePath $inst.FullName -Wait
}

#Getting windows updates
Write-Host "----------------------------------------------"
Write-Host "Installing NuGet module"
Install-PackageProvider -Name NuGet -Force -Scope CurrentUser
Write-Host "----------------------------------------------"
Write-Host "Installing Windows Updater module "
Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser
Write-Host "----------------------------------------------"
Write-Host "Getting Windows Updates"
try
{
    Get-WUlist -MicrosoftUpdate
}
catch
{
    Write-Host "----------------------------------------------"
    Write-Host "FAILED getting Windows Updates. Trying Again"
    Reset-WUComponents -Verbose
    Get-WUlist -MicrosoftUpdate
}
Write-Host "----------------------------------------------"
Write-Host "Installing Windows Updates"
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll
Write-Host "----------------------------------------------"
Write-Host "Unstalling NuGet module"
(Get-PackageProvider NuGet).ProviderPath | Remove-Item -force
Write-Host "----------------------------------------------"
Write-Host "Unstalling Windows Updater module"
uninstall-Module -Name PSWindowsUpdate -Force
#Restart-Computer -Force
