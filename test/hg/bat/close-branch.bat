if "%~1"=="" goto invalidrepo
hg commit -R %~dp0\%1 --config ui.username=test --close-branch -m "closed"
hg push -R %~dp0\%1
goto done

:invalidrepo
echo Invalid repository
exit /b 1;

:done
