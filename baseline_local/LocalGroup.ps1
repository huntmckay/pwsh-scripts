Get-LocalGroup | ConvertTo-Json | Set-Content .\baseline\"$((Get-Date).ToString("yyyyMMdd_HHmmss"))_localGroup.json"
