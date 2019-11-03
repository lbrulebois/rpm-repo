REM -----
REM Package : rpm/core
REM Version : 0.3.0
REM 
REM Uninstallation package for the module rpm/core.
REM -----
@echo off

REM -----
REM Global variables
set PKG_ROOT_DIR=%~dp0
set PKG_CODE=rpm-core
REM -----

REM We need to remove all the files installed previously ...
set FilesToDel=%SCRIPT_DIR%list.bat %SCRIPT_DIR%apply.bat %SCRIPT_DIR%update.bat %SCRIPT_DIR%utils\buildshct.bat
set FilesToDel=%FilesToDel% %SCRIPT_LOG_DIR%deploy_%PKG_CODE%.log
for %%f in (%FilesToDel%) do (
    if exist %%f ( del /s /f /q %%f > nul )
)