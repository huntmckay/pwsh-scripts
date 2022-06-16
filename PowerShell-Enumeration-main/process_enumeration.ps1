$survey_block = {

    # Get all of the process, enrich in place
    Function Survey-Processes(){
        $p = Get-Process -IncludeUserName | Select-Object UserName,ProcessName,Path,StartTime,Modules,Id
        $w = Get-WmiObject win32_process
        $t = Get-NetTCPConnection | Select-Object LocalAddress,LocalPort,RemoteAddress,RemotePort,OwningProcess,CreationTime,State
        $u = Get-NetUDPEndpoint | Select-Object LocalAddress,LocalPort,OwningProcess,CreationTime

        $processes = @{}

        $p | ForEach{
            # make a key of the pid and start time
            $process = @{}

            # pull the standard attributes
            $process.Add("UserName", $_.UserName)
            $process.Add("ProcessName", $_.ProcessName)
            $process.Add("Path", $_.Path)
            If($_.StartTime -NE $null){
                $epoch = [Math]::Floor([decimal](Get-Date($_.StartTime).ToUniversalTime()-uformat "%s"))
            }
            Else{
                $epoch = 0
            }
            $process.Add("StartTime", $epoch)
            $process.Add("Modules", $_.Modules.ModuleName)

            # add the wmi attributes
            $wmi_proc = $w | Where-Object ProcessId -EQ $_.Id
            $process.Add("CommandLine", $wmi_proc.CommandLine)

            # add the tcp connections
            $tcp = $t | Where-Object OwningProcess -EQ $_.Id
            $process.Add("TCPConnections", $tcp)

            # add the udp connections
            $udp = $u | Where-Object OwningProcess -EQ $_.Id
            $process.Add("UDPConnections", $udp)
    
            $processes.Add($_.Id.ToString(), $process)
        }

        Return $processes
    }

    # check event logs $event_ids = 1102,4719,4618,4649,4765,4766,4794,4897,4964,5124,4706,4713,4724
    #Get-EventLog Security -InstanceId 1102,4719,4618,4649,4765,4766,4794,4897,4964,5124,4706,4713,4724

    # get authentication event logs
    Function Survey-AuthLogs(){
        $auth_logs = Get-EventLog Security -InstanceId 4624,4625 | Select-Object TimeGenerated,ReplacementStrings,MachineName,EntryType,Index
        Return $auth_logs
    }

    # list files
    Function Get-UserFiles(){
        $files = Get-ChildItem -Recurse "C:\Users\" -File -Depth 2
        Return $files
    }

    # list services
    Function Survey-Services(){
        $services = Get-WmiObject -Class Win32_Service | Select Name,Status,PathName,StartMode,Caption,Description,DisplayName,ProcessId,Started,State
        Return $services
    }

    # check wmi objects 
    Function Survey-WmiObjects(){
        $objects = @{}
        $wmi_objects = "win32_startupcommand","win32_networkloginprofile","win32_systemdriver","win32_mappedlogicaldisk","win32_environment","win32_useraccount","win32_group","win32_computersystem","win32_networkadapterconfiguration","win32_share","win32_logicaldisk","win32_quickfixengineering","win32_operatingsystem","win32_pointingdevice","win32_service","win32_printerdriver","win32_printer","win32_networkconnection","win32_networkadapter","win32_bios"

        $wmi_objects | ForEach{
            $obj = Get-WmiObject -Class $_
            If(($obj | Measure-Object).Count -gt 0){
                $filtered = $obj | Select-Object $obj[0].PSStandardMembers.DefaultDisplayPropertySet.ReferencedPropertyNames
            }
            Else{
                $filtered = $obj
            }
            $objects.Add($_, $filtered)
        }

        Return $objects
    }

    # check local users
    Function Survey-Users(){
        $users = Get-WmiObject -Class Win32_UserAccount | Select-Object Caption,PasswordExpires,AccountType,Description,Disabled,Name,SID
        Return $users
    }

    (Survey-Processes),(Survey-AuthLogs),(Survey-Services),(Survey-WmiObjects),(Survey-Users)
}

$target = "localhost"

$results = Invoke-Command -ComputerName $target -Credential (Get-Credential) -ScriptBlock $survey_block

$epoch = [Math]::Floor([decimal](Get-Date(Get-Date).ToUniversalTime()-uformat "%s"))
$dn = "$epoch`_$target`_survey"

New-Item -ItemType Directory $dn

$results[0] | ConvertTo-Json | Out-File $dn\processes.json
$results[1] | ConvertTo-Json | Out-File $dn\authentication.json
$results[2] | ConvertTo-Json | Out-File $dn\services.json
$results[3] | ConvertTo-Json | Out-File $dn\wmi_objects.json
$results[4] | ConvertTo-Json | Out-File $dn\local_users.json