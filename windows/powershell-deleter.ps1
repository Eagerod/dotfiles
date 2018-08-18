# This script will uninstall a whole bunch of packages.
# It may need to be run several times in the interest of dealing with dependencies.
# Some uninstallations may fail for the wildcard packages, and that's ok. Not everything needs
#   to be uninstalled. This is just meant to be a helper to make sure that fewer default 
#   packages are cluttering a fresh system.

# Uninstall default bundled games
Get-AppxPackage 828B5831* | Remove-AppxPackage
Get-AppxPackage A278AB0D* | Remove-AppxPackage
Get-AppxPackage Nordcurrent* | Remove-AppxPackage
Get-AppxPackage king.com* | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage

# Uninstall all store, zune, bing, and xbox packages (General Microsoft services)
Get-AppxPackage *bing* | Remove-AppxPackage
Get-AppxPackage *store* | Remove-AppxPackage
Get-AppxPackage *zune* | Remove-AppxPackage
Get-AppxPackage *xbox* | Remove-AppxPackage

# Uninstall everything from the Office suite (commented out in case it's installed on purpose).
# Get-AppxPackage Microsoft.Office* | Remove-AppxPackage

# Uninstall other Windows/Microsoft packages that don't seem super useful
# Ordering should allow for this to only be run once to get everything, but
#   there may be odd dependencies that will require this to be run multiple
#   times.
Get-AppxPackage microsoft.windowscommunicationsapps | Remove-AppxPackage
Get-AppxPackage Microsoft.Advertising* | Remove-AppxPackage
Get-AppxPackage Microsoft.Wallet | Remove-AppxPackage
Get-AppxPackage Microsoft.Messaging | Remove-AppxPackage
Get-AppxPackage Microsoft.Microsoft3DViewer | Remove-AppxPackage
Get-AppxPackage Microsoft.Print3D | Remove-AppxPackage
Get-AppxPackage Microsoft.OneConnect | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsMaps | Remove-AppxPackage
Get-AppxPackage Microsoft.WebMediaExtensions | Remove-AppxPackage
Get-AppxPackage Microsoft.People | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsCamera | Remove-AppxPackage
Get-AppxPackage WindowsFeedbackHub | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage
Get-AppxPackage DesktopAppInstaller | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftStickyNotes | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsPhone | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsDVDPlayer | Remove-AppxPackage
Get-AppxPackage Microsoft.GetHelp | Remove-AppxPackage

