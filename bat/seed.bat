set /p confirmDeploy=Are you sure you want to seed the database [y/n] ?:
if %confirmDeploy%==y goto :OK
goto :CANCEL

if $1 = 3
:OK
rake db:seed
pause 0

:CANCEL
pause 0