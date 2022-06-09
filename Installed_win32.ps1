Get-CimInstance -ClassName Win32_Product | ConvertTo-Json | Set-Content .\baseline\"Installed_win32$((Get-Date).ToString("HHmm_yyyyMMdd")).json"



# this is smaller output but missing a lot of data, probably needs more fields from above
Get-CimInstance -ClassName Win32_Product |Select-Object Name,Version,Vendor,InstallDate,InstallSource,InstallLocation,PackageName,LocalPackage| ConvertTo-Json | Set-Content .\baseline\"Installed_win32$((Get-Date).ToString("HHmm_yyyyMMdd")).json"
