Get-CimInstance –ClassName Win32_ComputerSystem | Select-Object Name, UserName, PrimaryOwnerName, Domain, TotalPhysicalMemory, Model, Manufacturer
