#Get Registry key info to cross reference
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" | Select-Object ReleaseId | ConvertTo-Json | Set-Content .\baseline\"$((Get-Date).ToString("yyyyMMdd_HHmmss"))_localGroup.json"

#get-CimInstance Method
Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -property CSNAME,* -ExcludeProperty Status,Name,Caption,Description,CreationClassName,CSCreationClassName,Distributed,MaxNumberOfProcesses,MaxProcessMemeorySize,NumberOfLicensedUsers,OSType,OtherTypeDescription,SizeStoredInPagingFiles,TotalSwapSpaceSize,CodeSetCSDVersion,Debug,ForegroundApplicationBoost,LargeSystemCache,Manufacturer,MUILanguages,OperatingSystemSKU,OSLanguage,OSProductSuite,PAEEnabled,PlusProductID,PlusVersionNumber,ProductType,SuiteMask,CimClass,CimInstanceProperties,CimSystemProperties,PSComputerName
