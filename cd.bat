@echo off

rem // cd like linux

if "%~1" equ "" (
  if %HOME% neq "" (
    rem // user setting home
    cd /D %HOME%
  ) else (
    rem // windows default home
    cd /D %HOMEDRIVE%%HOMEPATH%
  )
) else (
  rem // normal cd
  cd %1 %2 %3 %4 %5 %6 %7 %8 %9
)
