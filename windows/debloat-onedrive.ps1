# Kill OneDrive.
taskkill /f /im OneDrive.exe
& "$Env:SystemRoot\SysWOW64\OneDriveSetup.exe" /uninstall
