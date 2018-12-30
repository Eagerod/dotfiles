# This script will uninstall a whole bunch of packages.
# It may need to be run several times in the interest of dealing with dependencies.
# Some uninstallations may fail for the wildcard packages, and that's ok. Not everything needs
#   to be uninstalled. This is just meant to be a helper to make sure that fewer default 
#   packages are cluttering a fresh system.

# Uninstall default bundled games
Get-AppxPackage 828B5831* | remove-appxpackage
get-appxpackage A278AB0D* | remove-appxpackage
get-appxpackage Nordcurrent* | remove-appxpackage
get-appxpackage king.com* | remove-appxpackage

# Uninstall all store, zune, bing, and xbox packages (General Microsoft services)
get-appxpackage *bing* | remove-appxpackage
get-appxpackage *store* | remove-appxpackage
get-appxpackage *zune* | remove-appxpackage
get-appxpackage *xbox* | remove-appxpackage

# Uninstall everything from the Office suite (commented out in case it's installed on purpose.
# get-appxpackage Microsoft.Office* | remove-appxpackage

# Uninstall other Windows/Microsoft packages that don't seem super useful
get-appxpackage Microsoft.Advertising* | remove-appxpackage
get-appxpackage Microsoft.Wallet | remove-appxpackage
get-appxpackage Microsoft.Messaging | remove-appxpackage
get-appxpackage Microsoft.Microsoft3DViewer | remove-appxpackage
get-appxpackage Microsoft.Print3D | remove-appxpackage
get-appxpackage Microsoft.OneConnect | remove-appxpackage
get-appxpackage Microsoft.WindowsMaps | remove-appxpackage
get-appxpackage Microsoft.WebMediaExtensions | remove-appxpackage
get-appxpackage Microsoft.People | remove-appxpackage
get-appxpackage Microsoft.WindowsCamera | remove-appxpackage
get-appxpackage WindowsFeedbackHub | remove-appxpackage
get-appxpackage Microsoft.MicrosoftOfficeHub | remove-appxpackage
get-appxpackage DesktopAppInstaller | remove-appxpackage
get-appxpackage Microsoft.MicrosoftStickyNotes | remove-appxpackage
get-appxpackage Microsoft.WindowsPhone | remove-appxpackage
