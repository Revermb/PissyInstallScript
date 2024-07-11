Start-Process -Verb RunAs powershell.exe
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

Write-Host "----------------------------------------------"
Write-Host "Installing NuGet module"
Write-Host "----------------------------------------------"
Install-PackageProvider -Name NuGet -Force
Write-Host "----------------------------------------------"
Write-Host "Installing Windows Updater module "
Write-Host "----------------------------------------------"
Install-Module -Name PSWindowsUpdate -Force
Write-Host "----------------------------------------------"
Write-Host "Getting Windows Updates"
Write-Host "----------------------------------------------"
try
(
    Get-WUlist -MicrosoftUpdate
)
catch
(
    Reset-WUComponents -Verbose
    Get-WUlist -MicrosoftUpdate
)
Write-Host "----------------------------------------------"
Write-Host "Installing Windows Updates"
Write-Host "----------------------------------------------"
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll
Write-Host "----------------------------------------------"
Write-Host "Unstalling Windows Updater module"
Write-Host "----------------------------------------------"
uninstall-Module -Name PSWindowsUpdate -Force
Write-Host "----------------------------------------------"
Write-Host "Unstalling NuGet module"
Write-Host "----------------------------------------------"
(Get-PackageProvider NuGet).ProviderPath | Remove-Item -force
Restart-Computer -Force
