echo off
echo Starting incoming hook with onNewBranch: %1 onExistingBranch: %2 onCloseBranch: %3
SETLOCAL
FOR /F "tokens=*" %%a in ('hg log --rev %HG_NODE% --template "{branch}\n"') do SET BRANCH=%%a

set first=hg log -r "min(branch(%BRANCH%))" --template "{node}\n"
set closed=hg log -r "closed() and branch(%BRANCH%)" --template "{node}\n"
FOR /F "tokens=*" %%f in ('%first%') do SET INITIAL=%%f
rem On new branch
if "%HG_NODE%"=="%INITIAL%" (
if not "%~1"=="" call %~1 "%BRANCH%" "%HG_NODE%"
goto done
)
FOR /F "tokens=*" %%f in ('%closed%') do SET CLOSE=%%f

rem On close branch
if "%HG_NODE%"=="%CLOSE%" (
if not "%~3"=="" call %~3 "%BRANCH%" "%HG_NODE%"
goto done
)

rem On existing branch
if not "%~2"=="" call %~2 "%BRANCH%" "%HG_NODE%"
goto done
:done