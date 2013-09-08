set /p confirmDeploy=Are you sure you want to clear all data [y/n] ?:
if %confirmDeploy%==y goto :OK
goto :CANCEL

if $1 = 3
:OK
rake db:drop
pause 0

:CANCEL
pause 0