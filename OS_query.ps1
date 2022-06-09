Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | Select-Object ReleaseId | ConvertTo-Json | Set-Content .\baseline\"$((Get-Date).ToString("yyyyMMdd_HHmmss"))_localGroup.json"


Get-CIMInstance Win32_OperatingSystem | Select-Object Caption, Version, servicepackmajorversion, BuildNumber, CSName, LastBootUpTime | ConvertTo-Json | Set-Content .\baseline\"$((Get-Date).ToString("yyyyMMdd_HHmmss"))_localGroup.json"

Get-HotFix * | ConvertTo-Json | Set-Content .\baseline\"$((Get-Date).ToString("yyyyMMdd_HHmmss"))_localGroup.json"
