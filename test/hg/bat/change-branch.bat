IF [%2] == [] GOTO BranchNotSet


for /f %%i in ('hg -R %1 branch') do set current=%%i

if [%2] == [%current%] GOTO Ready

hg -R %1 branch %2
hg -R %1 push -f
GOTO Ready


:BranchNotSet
echo "ERROR: Cannot change branch if it is not defined"
exit 1

:Ready

