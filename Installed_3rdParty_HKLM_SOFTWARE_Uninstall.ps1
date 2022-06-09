Get-ItemProperty "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | Select-Object DisplayName, DisplayVersion, InstallDate, Publisher | ConvertTo-Json | Set-Content .\baseline\"Installed_HKLM_Software_Uninstall$((Get-Date).ToString("HHmm_yyyyMMdd")).json"


#More verbose, needs heavy filtering
Get-ItemProperty "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | ConvertTo-Json | Set-Content .\baseline\"Installed_HKLM_Software_Uninstall$((Get-Date).ToString("HHmm_yyyyMMdd")).json"

#lets user filter for specific program name
Get-ItemProperty "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | Where DisplayName -Like "*$USER_ARG*" | ConvertTo-Json | Set-Content .\baseline\"Installed_HKLM_Software_Uninstall$((Get-Date).ToString("HHmm_yyyyMMdd")).json"
