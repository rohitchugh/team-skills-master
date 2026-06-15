@echo off
REM Windows installer - double-click this file.
title Team Skills Master - Installer
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1"
if errorlevel 1 ( echo. & echo Install FAILED. Send this window to Rohit. )
echo.
pause
