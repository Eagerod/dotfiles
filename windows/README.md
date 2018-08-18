# Windows-Specific installation files

Windows isn't the greatest at being managed all in one nice place.
Chocolately kind of helps, and allows to install a few things that would otherwise be a lot more cumbersome to install, but it's hard to automate these scripts.

Instead of these being provided in bootstrap.sh, these will likely have to be installed by double clicking them, or by running a few scripts.

## Clean up base installation

Content can be added to this script as needed by investigating the contents of
```
Get-AppxPackage | Select Name, PackageFullName
```

There can be a reasonable amount of noise and desired applications in that list.
There are also some applications that just can't be uninstalled because of system dependencies
For a more culled down and more manageable list, this may be preferable
```
Get-AppxPackage |
    Where Name -NotLike "Microsoft.NET.Native.Runtime.*" |
    Where Name -NotLike "Microsoft.NET.Native.Framework.*" |
    Where Name -NE "Microsoft.XboxGameCallableUI" |
    Where Name -NE "Microsoft.Windows.Cortana" |
    Where Name -NE "Microsoft.MicrosoftEdge" |
    Where Name -NE "c5e2524a-ea46-4f67-841f-6a9465d9d515" | # File Explorer
    Where Name -NE "Microsoft.MicrosoftEdge" |
	Select Name, PackageFullName
```

Another useful view may be to see what applications exist that aren't published by Microsoft.
```
Get-AppxPackage |
    Where PublisherId -NE "8wekyb3d8bbwe" |
    Where PublisherId -NE "cw5n1h2txyewy" |
	Select Name, PackageFullName
```

## Registry

A collection of registry files are present in ./registry that can all be run from a single powershell script to modify the system registry to enable and disable the things that are worth changing.
