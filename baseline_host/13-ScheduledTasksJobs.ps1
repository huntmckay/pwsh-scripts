#probably hard to filter off a dirty system but absolutely worth baselining
Get-ScheduledTask | Select-Object TaskName, TaskPath, Date, Author, Actions,
Triggers, Description, State | where Author -NotLike 'Microsoft*' | where Author -ne
$null | where Author -NotLike '*@%SystemRoot%\*'

#quick way of exporting a task to xml naturally
Export-ScheduledTask -TaskName updater1

#Scheduled jobs are collections of scheduled tasks or irregular tasks for multiple hosts
Get-ScheduledJob

Get-ScheduledJob -Id $INT_ARG | Get-JobTrigger

Get-Job

#keep prevents the scheduled job from disappearing
Recieve-Job -Id $INT_ARG -keep

