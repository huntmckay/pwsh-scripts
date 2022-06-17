# This script scans your subnet and does some basic DNS
# lookups on the IPs that respond.  Remember that this
# requires ICMP to be enabled and for the Windows firewall
# to allow ping responses, which may not be the default.

# figure out what your IP is
$ipconfig = Get-NetIPConfiguration | Where-Object IPv4DefaultGateway
$my_ip = $ipconfig.IPv4Address.IPAddress
Write-Host "The IP address of this computer is " -ForegroundColor Yellow -NoNewline
Write-Host "$my_ip`n" -ForegroundColor Green

# get the first three octets to scan your subnet
$slash_24 = $my_ip.Split(".")[0..2] -join "."

# keep track of what we find
$responses = New-Object -TypeName System.Collections.ArrayList

# actually scan the subnet
$count = 0
$progress = 0
1..254 | %{
    $response = ping -n 1 -w 250 "$slash_24.$_" | Select-String "TTL"
    If($response){
        $count += 1
        $responses.Add($response) > $null
        Write-Host "Receive response from $slash_24.$_" -ForegroundColor Green
        
    }
    # give the user a quick update
    $progress += 1
    $percent = [int](($progress*100)/254)
    Write-Progress -Activity "Ping Sweeping $slash_24.0/24" -PercentComplete $percent -Status "$percent% complete, $count host(s) discovered."
}
Write-Progress -Activity "Ping Sweeping $slash_24.0/24" -Status "Ready" -Completed

# do some basic parsing to give the user more information
Clear-Host
Write-Host "IP Address`tOS Guess`tDNS Name"
Write-Host "----------`t--------`t--------"
$responses | ForEach-Object{
    $tokens = $_.ToString().Split(" ")
    $ttl = [int]$tokens[-1].Split("=")[-1]
    $ip = $tokens[2].Replace(":", "")

    $dns_name = ""
    Try{
        $dns_name = (Resolve-DnsName $ip -Type PTR -ErrorAction Stop).NameHost
    }Catch{
        $dns_name = "NO_RECORD"
    }

    # make a guess about the OS/purpose based on TTL
    If($ttl -gt 200){
        Write-Host "$ip`tRouter/Embedded`t$dns_name"
    }
    Elseif($ttl -ge 65 -and $ttl -le 128){
        Write-Host "$ip`tLikely Windows`t$dns_name"
    }
    Else{
        Write-Host "$ip`tLikely Linux`t$dns_name"
    }
}
