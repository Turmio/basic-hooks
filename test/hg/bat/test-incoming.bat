@ECHO OFF
setlocal EnableDelayedExpansion

set result=0
set r1=repository1
set r2=repository2
call %~dp0\init-repos.bat %r1% %r2%
if errorlevel 1 (
    set result=1
    goto CLEANUP
)
set newbranch=%~dp0\newbranch
set existing=%~dp0\existing
set closed=%~dp0\closed
call %~dp0\add-hook.bat %r1% incoming "%~dp0\write-branch-node.bat %newbranch%" "%~dp0\write-branch-node.bat %existing%" "%~dp0\write-branch-node.bat %closed%"
if errorlevel 1 (
    set result=1
    goto CLEANUP
)

call %~dp0\change-file.bat %r2%
call %~dp0\change-file.bat %r2%
call %~dp0\close-branch.bat %r2%

rem Verify results
echo Starting to verify results
set expectedNew[0]=default
set expectedExisting[0]=default
set expectedClose[0]=default

rem TODO: calculate from above
set countNew=1
set countExisting=1
set countClosed=1

set i=0
for /f "tokens=*" %%a in (%newbranch%) do (
 for /F %%b in ("%%a") do (
     
    if not %%b == !expectedNew[%i%]!  (
        set result=1
        goto CLEANUP
    )
 )
 set /a i+=1
)

if not %i% == %countNew% (
    set result=1
    goto CLEANUP
)
echo Found all new branches
set i=0
for /f "tokens=*" %%a in (%existing%) do (
    for /F %%b in ("%%a") do (
     
    if not %%b == !expectedExisting[%i%]!  (
        set result=1
        goto CLEANUP
    )
 )
set /a i+=1
)

if not %i% == %countExisting% (
    set result=1
    goto CLEANUP
)
echo Found all existing

set i=0
for /f "tokens=*" %%a in (%closed%) do (
 for /F %%b in ("%%a") do (
     
    if not %%b == !expectedClose[%i%]!  (
        set result=1
        goto CLEANUP
    )
 )
 set /a i+=1
)

if not %i% == %countClosed% (
    set result=1
    goto CLEANUP
)
echo Found all closed
:CLEANUP
call %~dp0\cleanup.bat %r1% %r2%
del %newbranch%
del %existing%
del %closed%

if %result%==0 echo SUCCESS
if %result%==1 echo FAILURE
exit /b %result%

