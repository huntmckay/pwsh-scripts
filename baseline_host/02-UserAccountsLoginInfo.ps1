Get-LocalUser | ConvertTo-Json | Set-Content .\baseline\"localuser_$((Get-Date).ToString("HHmm_yyyyMMdd")).json"
Get-WinEvent 
Get-LocalGroup | ConvertTo-Json | Set-Content .\baseline\"$((Get-Date).ToString("yyyyMMdd_HHmmss"))_localGroup.json"
Get-ADUser -Filter 'Name -Like "*"' | where Enabled -eq $True
Get-ADGroupMember Administrators | Where-Object -eq 'user'
Get
#TODO Find a better way to reach into registry hives on live system 
#Get-ItemProperty "HKLM:\Domains\Account\Users\"

