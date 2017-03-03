if NOT EXIST "%~1" goto second
echo Removing folder %1
rmdir /S /Q %~dp0\%1

:second
if NOT EXIST "%~2" goto done
echo Removing folder %2
rmdir /S /Q %~dp0\%2

:DONE