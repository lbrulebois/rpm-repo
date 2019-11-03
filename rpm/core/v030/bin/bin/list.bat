REM -----
REM ACTION : list
REM USAGE :
REM rpm.bat list
REM   Will return the list of all the packages
REM   actually installed on this computer.
REM -----

echo  Command 'list' 
echo  -----
echo.

REM We get through the packages' directory and 
REM we return the informations about the items.
for /f "tokens=1*" %%V in ('dir /b /a:d "%SCRIPT_PKG_DIR%"') do (
    for /f "tokens=1*" %%P in ('dir /b /a:d "%SCRIPT_PKG_DIR%%%V"') do (
        set /p version=< %SCRIPT_PKG_DIR%%%V\%%P\version.txt
        echo  %%V/%%P = !version!
    )
)