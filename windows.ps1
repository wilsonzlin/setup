param(
  [Parameter(Mandatory = $true, Position = 1)]
  [string]$AtomsListFile
)

# Install Chocolatey.
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Increase/disable timeouts.
choco config set --name commandExecutionTimeoutSeconds --value 0
choco config set --name webRequestTimeoutSeconds --value 120
choco config set --usePackageExitCodes --value $false

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

foreach ($script in Get-Content -Path $AtomsListFile) {
  & "$PSScriptRoot/windows/$script.ps1"
}
