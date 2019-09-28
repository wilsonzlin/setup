# Remove packages.
Get-AppxPackage microsoft.bingnews | Remove-AppxPackage
Get-AppxPackage microsoft.bingweather | Remove-AppxPackage
Get-AppxPackage microsoft.gethelp | Remove-AppxPackage
Get-AppxPackage microsoft.getstarted | Remove-AppxPackage
Get-AppxPackage microsoft.messaging | Remove-AppxPackage
Get-AppxPackage microsoft.microsoft3dviewer | Remove-AppxPackage
Get-AppxPackage microsoft.microsoftofficehub | Remove-AppxPackage
Get-AppxPackage microsoft.microsoftsolitairecollection | Remove-AppxPackage
Get-AppxPackage microsoft.mixedreality.portal | Remove-AppxPackage
Get-AppxPackage microsoft.mspaint | Remove-AppxPackage
Get-AppxPackage microsoft.office.onenote | Remove-AppxPackage
Get-AppxPackage microsoft.oneconnect | Remove-AppxPackage
Get-AppxPackage microsoft.people | Remove-AppxPackage
# Connect app (Microsoft.PPIProjection) is a system app and cannot be uninstalled (1903).
# Get-AppxPackage microsoft.ppiprojection | Remove-AppxPackage
Get-AppxPackage microsoft.print3d | Remove-AppxPackage
Get-AppxPackage microsoft.skypeapp | Remove-AppxPackage
Get-AppxPackage microsoft.windows.photos | Remove-AppxPackage
Get-AppxPackage microsoft.windowsalarms | Remove-AppxPackage
Get-AppxPackage microsoft.windowscommunicationsapps | Remove-AppxPackage
Get-AppxPackage microsoft.windowsfeedbackhub | Remove-AppxPackage
Get-AppxPackage microsoft.windowsmaps | Remove-AppxPackage
Get-AppxPackage microsoft.windowssoundrecorder | Remove-AppxPackage
Get-AppxPackage microsoft.wallet | Remove-AppxPackage
Get-AppxPackage microsoft.yourphone | Remove-AppxPackage
Get-AppxPackage microsoft.zunemusic | Remove-AppxPackage
Get-AppxPackage microsoft.zunevideo | Remove-AppxPackage

# Kill OneDrive.
taskkill /f /im OneDrive.exe
& "$Env:SystemRoot\SysWOW64\OneDriveSetup.exe" /uninstall

# Enable Developer Mode.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"

# Configure optional Windows features.
Disable-WindowsOptionalFeature -Online -FeatureName Internet-Explorer-Optional-amd64 -NoRestart
Disable-WindowsOptionalFeature -Online -FeatureName WindowsMediaPlayer -NoRestart
Disable-WindowsOptionalFeature -Online -FeatureName WorkFolders-Client -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName NetFx3 -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart
Enable-WindowsOptionalFeature -Online -FeatureName DirectPlay -All -NoRestart

# Install Chocolatey.
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Set timeout to 24 hours.
choco config set --name commandExecutionTimeoutSeconds --value 86400

# Install programs.
choco install -y 7zip.install
choco install -y autohotkey.install
choco install -y dart-sdk
choco install -y dotnetcore-sdk
choco install -y eraser
choco install -y everything --params "/folder-context-menu /run-on-system-startup"
choco install -y firefox
choco install -y flutter
choco install -y gimp
choco install -y git.install
choco install -y golang
choco install -y googlechrome
choco install -y imageglass
choco install -y jetbrainstoolbox
choco install -y llvm
choco install -y lua
choco install -y miktex.install
choco install -y mpv.install
choco install -y nodejs.install
choco install -y notepadplusplus.install
choco install -y office365proplus
choco install -y openjdk
choco install -y origin
choco install -y php
choco install -y putty.install
choco install -y python2
choco install -y python3
choco install -y qbittorrent
choco install -y r.project
choco install -y r.studio
choco install -y rust
choco install -y sendtokindle
choco install -y spacesniffer
choco install -y steam
choco install -y sublimetext3
choco install -y terminus
choco install -y uplay
choco install -y visualstudio2019enterprise --package-parameters "--config $PSScriptRoot\windows\vsenterprise.vsconfig"
choco install -y vlc
choco install -y vscode
choco install -y zerotier-one
