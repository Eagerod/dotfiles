:: This script should be the only one that needs to be run to trigger the full
::   installation process for things in this directory.
:: Because this script actually installs the tool that can run shell scripts
::   on Windows, it's not included in the root bootstrap.sh, but should be
::   executable as is from within the windows directory.
:: This script runs commands that require admin privileges. If being run with
::   insufficient privileges, the script prints an error message and remains
::   open.
net session >nul 2>nul
if %errorLevel% == 0 (
	echo "Permissions check passed."
) else (
	echo "Insufficient privileges to run this script. Please run as administrator"
	pause
	exit
)

:: Running as administrator starts in C:\Windows\system32, so go to this
::   file's path before trying to do anything else.
cd %~dp0

powershell -ExecutionPolicy ByPass -File powershell-deleter.ps1

call choco_install.bat
call choco_packages.bat

call cyg_setup.bat

call configure_registry.bat

echo "Windows bootstrapping complete!"
pause



