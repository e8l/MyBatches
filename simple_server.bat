@echo off
setlocal enabledelayedexpansion

rem // run simple http server as a localhost.
rem // This batch needs Python or Ruby.

rem // check 1st argument as port number

if "%~1" equ "" (
  set /A arg=8000
) else (
  set arg=%1
)

rem // set port number

set /A PORT=%arg% * 1
if %PORT% neq %arg% (
  rem // case1: argument is not number
  set /A PORT=8000
) else if %PORT% lss 0 (
  rem // case2: argument is not valid(too small).
  set /A PORT=8000
) else if %PORT% gtr 65535 (
  rem // case3: argument is not valid(too big).
  set /A PORT=8000
) else (
goto MAIN
)

echo [Error] Argument is not valid port number. Use default port number 8000.

:MAIN

rem // When Python is installed.
where python > nul 2>&1

if %ERRORLEVEL% == 0 (
  
  rem // Is default python version 2?
  python -V 2>&1 | findstr "2\.[4-9]\..* 2\.[1-9][0-9]*\..*" > nul
  if %ERRORLEVEL% == 0 (
    python -m SimpleHTTPServer !PORT!
    goto END
  )
  
  rem // Is default python version 3?
  python -V 2>&1 | findstr "3\.[0-9]*\..*" > nul
  if %ERRORLEVEL% == 0 (
    python -m http.server !PORT!
    goto END
  )
)

rem // When Ruby is installed.
where ruby > nul 2>&1

if %ERRORLEVEL% == 0 (
  ruby -run -e httpd . -p !PORT!
  goto END
)

echo There is no server program.
echo Cannot start localhost.
exit /b 1

:END
endlocal
exit /b 0