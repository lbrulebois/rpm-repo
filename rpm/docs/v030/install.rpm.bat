REM -----
REM Package : rpm/docs
REM Version : 0.3.0
REM 
REM Installation package for the module rpm/docs.
REM -----
@echo off

REM -----
REM Global variables
set PKG_ROOT_DIR=%~dp0
set PKG_CODE=rpm-docs
REM -----

REM We need to copy the package content except
REM the install.rpm.bat script and the version.txt
REM in the local copy of the installator.
robocopy /E %PKG_ROOT_DIR%bin\ %SCRIPT_ROOT_DIR% > "%SCRIPT_LOG_DIR%deploy_%PKG_CODE%.log"