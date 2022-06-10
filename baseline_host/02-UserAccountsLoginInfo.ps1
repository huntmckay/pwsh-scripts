Get-LocalUser | ConvertTo-Json | Set-Content .\baseline\"localuser_$((Get-Date).ToString("HHmm_yyyyMMdd")).json"


Get-LocalGroup | ConvertTo-Json | Set-Content .\baseline\"$((Get-Date).ToString("yyyyMMdd_HHmmss"))_localGroup.json"


Get-CimInstance –ClassName Win32_ComputerSystem | Select-Object Name, UserName, PrimaryOwnerName, Domain, TotalPhysicalMemory, Model, Manufacturer
