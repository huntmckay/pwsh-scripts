
Get-Process | Select-Object *

#refined search with $INT_ARG

Get-Process | Select-Object StartTime,ProcessName,ID,PAth | Where Id -eq $INT_ARG


# Above lacks finite details for deeper investigation
Get-CimInstance -ClassName Win32_Process | Select-Object CreationDate,ProcessName,ProcessID,CommandLine,ParentProcessId | Where ProcessID -eq $INT_ARG
