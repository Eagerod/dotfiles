:: Note: This script is meant to get a fairly functional cygwin environment
::   ready to go without actually being the be-all end-all kind of solution.
:: apt-cyg is installed a convenience for on the fly work, and if something
::   needs to be persisted for more common use, it's probably best to include
::   it in the cygwinsetup params list.
C:\cygwin64\cygwinsetup.exe -q -P coreutils,wget,python2-pip,python2-devel,curl,git,vim,make,gcc-g++

C:\cygwin64\bin\bash --login -c '^
	wget https://raw.githubusercontent.com/transcode-open/apt-cyg/b6076c2900f3d4f8994f21c344b1e6d937c85ece/apt-cyg ^
		-O /usr/local/bin/apt-cyg; ^
	chmod 755 /usr/local/bin/apt-cyg; ^
	python -m pip install -U pip'

for /f %%i in ('C:\cygwin64\bin\bash --login -c "cygpath -w $(PWD)"') do set CYG_HOME=%%i
powershell -ExecutionPolicy ByPass -File create-cygwin-shortcut.ps1 %CYG_HOME%
