Get-CimInstance -ClassName Win32_Product | ConvertTo-Json | Set-Content .\baseline\"Installed_win32$((Get-Date).ToString("HHmm_yyyyMMdd")).json"



# this is smaller output but missing a lot of data, probably needs more fields from above
Get-CimInstance -ClassName Win32_Product |Select-Object Name,Version,Vendor,InstallDate,InstallSource,InstallLocation,PackageName,LocalPackage| ConvertTo-Json | Set-Content .\baseline\"Installed_win32$((Get-Date).ToString("HHmm_yyyyMMdd")).json"




Get-ItemProperty "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | Select-Object DisplayName, DisplayVersion, InstallDate, Publisher | ConvertTo-Json | Set-Content .\baseline\"Installed_HKLM_Software_Uninstall$((Get-Date).ToString("HHmm_yyyyMMdd")).json"


#More verbose, needs heavy filtering
Get-ItemProperty "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | ConvertTo-Json | Set-Content .\baseline\"Installed_HKLM_Software_Uninstall$((Get-Date).ToString("HHmm_yyyyMMdd")).json"

#lets user filter for specific program name
Get-ItemProperty "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | Where DisplayName -Like "*$USER_ARG*" | ConvertTo-Json | Set-Content .\baseline\"Installed_HKLM_Software_Uninstall$((Get-Date).ToString("HHmm_yyyyMMdd")).json"


Get-AuthenticodeSignature *




(get-process | select path -unique).name|foreach{ Get-AuthenticodeSignature $_ } | where-object Status -ne Valid
