# Remove packages.
# This is Cortana.
Get-AppxPackage -AllUsers microsoft.549981c3f5f10 | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.bingnews | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.bingweather | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.gethelp | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.getstarted | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.messaging | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.microsoft3dviewer | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.microsoftofficehub | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.microsoftsolitairecollection | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.mixedreality.portal | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.mspaint | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.office.onenote | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.oneconnect | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.people | Remove-AppxPackage
# Connect app (Microsoft.PPIProjection) is a system app and cannot be uninstalled (1903).
# Get-AppxPackage -AllUsers microsoft.ppiprojection | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.print3d | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.skypeapp | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.windows.photos | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.windowsalarms | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.windowscommunicationsapps | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.windowsfeedbackhub | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.windowsmaps | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.windowssoundrecorder | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.wallet | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.yourphone | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.zunemusic | Remove-AppxPackage
Get-AppxPackage -AllUsers microsoft.zunevideo | Remove-AppxPackage
