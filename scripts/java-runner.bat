@echo off
REM ==============================================================================
REM java-runner.bat - Windows launcher
REM Delegates to platform-specific script
REM ==============================================================================

REM Get script directory
set "SCRIPT_DIR=%~dp0"
set "PROJECT_ROOT=%SCRIPT_DIR%.."

REM Call Windows-specific script
call "%PROJECT_ROOT%\platforms\windows\scripts\java-runner.bat" %*
