REM -----
REM Package : rpm/docs
REM Version : 0.3.0
REM 
REM Uninstallation package for the module rpm/docs.
REM -----
@echo off

REM -----
REM Global variables
set PKG_ROOT_DIR=%~dp0
set PKG_CODE=rpm-docs
REM -----

REM We need to remove all the files installed previously ...
set FilesToDel=%SCRIPT_MAN_DIR%apply.txt %SCRIPT_MAN_DIR%list.txt %SCRIPT_MAN_DIR%install.txt %SCRIPT_MAN_DIR%uninstall.txt %SCRIPT_MAN_DIR%update.txt %SCRIPT_MAN_DIR%usage.txt 
set FilesToDel=%FilesToDel% %SCRIPT_LOG_DIR%deploy_%PKG_CODE%.log %SCRIPT_LOG_DIR%dl_%PKG_CODE%.log
for %%f in (%FilesToDel%) do (
    if exist %%f ( del /s /f /q %%f > nul )
)