Get-ADUser -Filter 'Name -Like "*"' | ConvertTo-Json | Set-Content .\baseline_domain\"ADUsers_$((Get-Date).ToString("HHmm_yyyyMMdd")).json"


Get-ADGroupMember Administrators | Where objectClass -eq 'user' | ConvertTo-Json | Set-Content .\baseline_domain\"ADAdmins_$((Get-Date).ToString("HHmm_yyyyMMdd")).json"

Get-ADComputer -Filter "Name -Like '*'" -Properties * | where Enabled
-eq $True | Select-Object Name, OperatingSystem, Enabled


