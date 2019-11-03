:: -----
:: ACTION : buildshct
:: USAGE :
:: buildshct.bat <destdir> <name> <path> [<icon>, <description>, <workdir>]
::   Will create a shorcut with the given informations
::   (path, icon, title, ...) to the given destination.
:: -----

@echo off
setlocal enabledelayedexpansion

set DestDir=
set Name=
set Path=
set Icon=""
set Description=""
set WorkDir=""

:: -----
:: Exit codes
set EC_SUCCESS=0
set EC_CRITICAL=1
set EC_ARGSEXCP=10
set EC_DESTDIR_NOTFOUND=11
set EC_SHORTCUT_EXISTS=12
:: -----

:: STEP 1
:: We check that the needed arguments are setted and
:: are valid ...
set /A ArgsCount=0
FOR %%A in (%*) DO (set /A ArgsCount+=1)

if %ArgsCount% LSS 3 (
    if %ArgsCount% EQU 0 echo  #Sorry, the destination's directory must be setted.
    if %ArgsCount% EQU 1 echo  #Sorry, the shorcut's name must be setted.
    if %ArgsCount% EQU 2 echo  #Sorry, the shorcut's path must be setted.
    exit /B %EC_ARGSEXCP%
)

set DestDir=%1
set DestDir=%DestDir:"=%
set Name=%2
set Name=%Name:"=%
set Path=%3
set Path=%Path:"=%

if %ArgsCount% EQU 4 if exist %4 set Icon=%4
if %ArgsCount% EQU 5 set Description=%5
if %ArgsCount% EQU 6 if exist %6 set WorkDir=%6
set Icon=%Icon:"=%
set Description=%Description:"=%
set WorkDir=%WorkDir:"=%

:: We check that the destination's directory exist ...
if not exist %DestDir% (
    echo  #Sorry, the destination's directory doesn't exist.
    exit /B %EC_DESTDIR_NOTFOUND%
)

:: We check that the shortcut doesn't exist yet ...
if exist "%DestDir%\%Name%.lnk" (
    echo  #Sorry, the shorcut already exists.
    exit /B %EC_SHORTCUT_EXISTS%
)

:: STEP 2
:: We can generate the new shortcut ...
echo DestDir     = %DestDir%
echo Name        = %Name%
echo Path        = %Path%
echo Icon        = %Icon%
echo Description = %Description%
echo WorkDir     = %WorkDir%
echo.


set ScriptBuildShct="%TEMP%\Build_Shct_%Name:"=%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %ScriptBuildShct%
echo sLinkFile = "%DestDir%\%Name%.lnk" >> %ScriptBuildShct%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %ScriptBuildShct%
echo oLink.TargetPath = "%Path%" >> %ScriptBuildShct%
REM echo oLink.Arguments = ""
echo oLink.Description = "%Description%" >> %ScriptBuildShct%
REM echo oLink.HotKey = ""
REM echo oLink.IconLocation = ""
REM echo oLink.WindowStyle = ""
echo oLink.WorkingDirectory = "%WorkDir%" >> %ScriptBuildShct%
echo oLink.Save >> %ScriptBuildShct%

cscript /nologo %ScriptBuildShct%
del %ScriptBuildShct%