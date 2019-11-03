REM -----
REM ACTION : update
REM USAGE :
REM rpm.bat update
REM   Will check if upgrades are availables for
REM   the actual installed packages and will update
REM   them.
REM -----

setlocal enabledelayedexpansion

echo  Command 'update' 
echo  -----
echo.

REM We get through the packages' directory to 
REM get the informations about the installed items.
for /f "tokens=1*" %%V in ('dir /b /a:d "%SCRIPT_PKG_DIR%"') do (
    for /f "tokens=1*" %%P in ('dir /b /a:d "%SCRIPT_PKG_DIR%%%V"') do (
        set /p version=< %SCRIPT_PKG_DIR%%%V\%%P\version.txt
        echo  %%V/%%P = !version!
        
        REM We're looking if a new version is available for this package,
        REM we first check that the package is always available ...
        set Package=%%V/%%P
        if not exist "!CONF_REPOSITORY!!Package!" (
            echo  #Sorry : no package found for the code !Package!.
            REM exit /B !EC_UPDATE_BADPKGCODE!
        )

        REM We're getting all the informations about the package
        REM to install and first, we get the last version of the product ...
        set LastVersion=
        for /f "tokens=1*" %%G in ('dir /b /o:-n /a:d "!CONF_REPOSITORY!!Package!"') do (
            if not defined LastVersion (set LastVersion=%%G)
        )

        REM If the actual installed version is out of date
        REM we can update the product ...
        if "!version:~1,-1!" LSS "!LastVersion:~1!" (
            echo     An update is available : !LastVersion!
            set /P UpdatePackage=Would you like to upgrade this package ? [y/n] :
            if /I "!UpdatePackage!" EQU "Y" (
                call %SCRIPT_ROOT_DIR%\rpm.bat install !Package!
            ) 
        ) else (
            echo     The package is already up to date
        )
    )
)