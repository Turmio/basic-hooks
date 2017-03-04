echo Writing %*
if "%~1"=="" goto invalidfile

echo %2 %3>>%1

goto done

:invalidfile
echo File cannot be null. Cannot write branch and node.
exit /b 1

:done