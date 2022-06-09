Get-LocalUser | ConvertTo-Json | Set-Content .\baseline\"localuser_$((Get-Date).ToString("HHmm_yyyyMMdd")).json"
