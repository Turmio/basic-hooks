if "%~1"=="" goto invalidrepo
if "%~2"=="" goto invalidfile
echo text >> %~dp0\%1\%2
hg add -R %~dp0\%1 %~dp0\%1\*
hg commit -R %~dp0\%1 --config ui.username=test -m "changed file from %0"
hg push -R %~dp0\%1
goto done

:invalidrepo
echo Invalid repository
exit /b 1

:invalidfile
echo Filename cannot be empty
exit /b 1

:done
