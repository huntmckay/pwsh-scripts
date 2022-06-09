#Toolie for investigating outbound traffic TCP/UDP I think there is a lot more tooling that can be built here


#TCP connections userargs required here
Get-NetTCPConnection -RemoteAddress 52.46.157.11 -RemotePort 8080 | Select-Object CreationTime, LocalAddress, LocalPort, RemoteAddres, RemotePort, OwningProcess, State

#UDP connections userargs also required here
Get-NETUDPEndpoint -RemoteAddress 52.46.157.11 -RemotePort 8080 | Select-Object CreationTime, LocalAddress, LocalPort, RemoteAddres, RemotePort, OwningProcess, State
