# Windows-Specific installation files

Windows isn't the greatest at being managed all in one nice place.
Chocolately kind of helps, and allows to install a few things that would otherwise be a lot more cumbersome to install, but it's hard to automate these scripts.

Instead of these being provided in bootstrap.sh, these will likely have to be installed by double clicking them, or by running a few scripts.

## Clean up base installation

To run the clean sweeper (powershell-deleter.ps1) run the following in an elevated permissions powershell:
```
powershell -ExecutionPolicy ByPass -File powershell-deleter.ps1
```
Windows usually has a default PowerShell execution policy that prevents running PowerShell scripts.

Content can be added to this script as needed by investigating the contents of
```
Get-AppxPackage | Select Name, PackageFullName
```

## Registry

A collection of registry files are present in ./registry that can all be run from a single powershell script to modify the system registry to enable and disable the things that are worth changing.
