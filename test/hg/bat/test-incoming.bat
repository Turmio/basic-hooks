@ECHO OFF
set r1=repository1
set r2=repository2
call %~dp0\init-repos.bat %r1% %r2%
if errorlevel 1 goto FAILURE

call %~dp0\add-hook.bat incoming
if errorlevel 1 goto FAILURE

:FAILURE
call %~dp0\cleanup.bat %r1% %r2%
exit /b 1

:CLEANUP
call %~dp0\cleanup.bat %r1% %r2%
