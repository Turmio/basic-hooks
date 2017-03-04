if "%~1"=="" goto nohook
set repo=%1
set hook=%~dp0\..\..\..\src\hg\bat\%2.bat

if NOT EXIST "%hook%" goto invalidhook
if "%~1"=="" goto invalidrepo

set hgrc=%~dp0\%1\.hg\hgrc

echo [hooks]>> %hgrc%
echo %2 = %hook% %3 %4 %5>> %hgrc%

goto done

:nohook
echo First parameter should be hook's name
exit /b 1

:invalidhook
echo Hook does not exist
exit /b 1

:invalidrepo
echo Repository does not exist
exit /b 1

:done