
#lacking importance attributes, see below for better
Get-Service | Select-Object Name, DisplayName, Status, StartType

#can probably get more data of this as well
Get-CimInstance -ClassName Win32_service | select-Object Name,DisplayName,StartMode,State,PathName,StartName,ServiceType


