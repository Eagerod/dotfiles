# Windows-Specific installation files

Windows isn't the greatest at being managed all in one nice place.
Chocolately kind of helps, and allows to install a few things that would otherwise be a lot more cumbersome to install, but it's hard to automate these scripts.

Instead of these being provided in bootstrap.sh, these will likely have to be installed by double clicking them, or by running a few scripts.

To run the clean sweeper (clean-installation.ps1) run the following:
```
powershell -ExecutionPolicy ByPass -File .\clean-installation.ps1
```
Windows usually has a default PowerShell execution policy that prevents running PowerShell scripts.
