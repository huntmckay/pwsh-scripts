$creds = Import-Clixml .\creds.xml

#####

$sesh = New-PSSession -Credential $creds -ComputerName win2012

$procs = Invoke-Comand -session $sesh -ScriptBlock{ Get-Process }

$procs | Convert-to-json | outfile -noclobber win($date)_processes.json

$sesh | Remove-PSSession
