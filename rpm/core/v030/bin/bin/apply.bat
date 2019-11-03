REM -----
REM ACTION : apply
REM USAGE :
REM rpm.bat apply <deployment>
REM   Will apply a list of actions (install or uninstall)
REM   of differents packages.
REM -----
setlocal enabledelayedexpansion

set Deployment=
set Deployment=%1

echo  Command 'apply' 
echo  -----
echo  deployment      = %Deployment% (required)
echo  -----
echo.

REM STEP 1
REM We check that the first argument is setted and
REM is valid ...
set /A ArgsCount=0
FOR %%A in (%*) DO (set /A ArgsCount+=1)

if %ArgsCount% LSS 1 (
    echo  #Sorry, the deployment's filepath must be setted.
    exit /B %EC_APPLY_NOFILEPATH%
)

REM We check if there is a package available 
REM for this code ...
if not exist "%Deployment%" (
    echo  #Sorry : the deployment's file %Deployment% doesn't exist.
    exit /B %EC_APPLY_BADFILEPATH%
)

REM STEP 2
REM The file exists, we read it and apply all the 
REM orders (installation or uninstallation).
for /f "delims=" %%l in (%Deployment%) do (
    REM We first get the data to build the good query
    set /a NbArgs=0
    set ActionToDo=
    set Package=
    set AdditionalArgs=
    for %%a in (%%l) do (
        if "!NbArgs!" == "0" ( set ActionToDo=%%a)
        if "!NbArgs!" == "1" ( set Package=%%a)
        if !NbArgs! GEQ 2 ( set AdditionalArgs=!AdditionalArgs!%%a )
        set /a NbArgs+=1
    )

    REM Then we apply it, if it's a restart order ...
    if "!ActionToDo!" == "r" (
        if "!Package!" == "" (
            set REBOOT_TIMER=%CONF_DEF_REBOOT%
        ) else (
            set REBOOT_TIMER=!Package!
        )
        shutdown /r /t !REBOOT_TIMER!
    )

    REM If it's an install order ...
    if "!ActionToDo!" == "i" (
        call %SCRIPT_ROOT_DIR%\rpm.bat install !Package! !AdditionalArgs!
    )

    REM If it's an uninstall order ...
    if "!ActionTodo!" == "u" (
        call %SCRIPT_ROOT_DIR%\rpm.bat uninstall !Package! !AdditionalArgs!
    )

    echo.
)