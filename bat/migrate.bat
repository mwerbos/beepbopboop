set /p confirmDeploy=Are you sure you want to migrate the database [y/n] ?:
if %confirmDeploy%==y goto :OK
goto :CANCEL

if $1 = 3
:OK
rake db:migrate
pause 0

:CANCEL
pause 0