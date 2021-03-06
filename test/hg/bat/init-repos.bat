echo %1
if "%~1"=="" goto parameter1
if "%~2"=="" goto parameter2
echo Creating repository %1
hg init  %~dp0\%1
if errorlevel 1 goto hgerror
echo Cloning %2 from %1
hg clone %~dp0\%1 %~dp0\%2
if errorlevel 1 goto hgerror
goto DONE

:PARAMETER1
echo First parameter should be name of initial repository
exit /b 1

:PARAMETER2
echo First parameter should be name of cloned repository
exit /b 1

:hgerror
exit /b 1

:DONE
