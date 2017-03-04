if "%~1"=="" goto invalidrepo
cd %~dp0\%1
echo text >> file
hg add *
hg commit -m "changed file from %0"
hg push
goto done

:invalidrepo
echo Invalid repository
cd %~dp0
exit /b 1;

:done
cd %~dp0