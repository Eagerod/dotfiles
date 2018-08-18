param([String]$cyg_home=30)

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$Home\Desktop\Cygwin Home.lnk")
$Shortcut.TargetPath = $cyg_home
$Shortcut.Save()
