if "%~1"=="" goto invalidrepo
cd %~dp0\%1
hg commit --close-branch -m "closed"
hg push
goto done

:invalidrepo
echo Invalid repository
cd %~dp0
exit /b 1;

:done
cd %~dp0