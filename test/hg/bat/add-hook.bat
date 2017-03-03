if "%~1"=="" goto nohook
set hook=%~dp0\..\..\..\src\hg\bat\%1.bat

if NOT EXIST "%hook%" goto invalidhook

goto done

:nohook
echo First parameter should be hook's name
exit /b 1

:invalidhook
echo Hook does not exists
exit /b 1

:done