Get-Content .\hosts.txt | ForEach{
    Write-Host "Searching processes for injection on $_" -ForegroundColor Yellow

    $computer = $_

    # generate a file name
    $epoch = [Math]::Floor([decimal](Get-Date(Get-Date).ToUniversalTime()-uformat "%s"))
    $fn = "injectscan_$computer`_$epoch.txt"
    $start = Get-Date

    Invoke-Command -ScriptBlock $sb -ComputerName $_ -Credential $creds | Out-File ".\injectscan_data\$fn" -Encoding utf8

    $duration = (Get-Date) - $start
    $seconds = [int]($duration.TotalSeconds)
    Write-Host "Completed $computer in $seconds seconds"

    # display a message about results
    If((Get-ChildItem ".\injectscan_data\$fn").Length -eq 0){
        Write-Host "No process injection found!" -ForegroundColor Green
    }
    Else{
        Write-Host "Process injection found on $computer" -ForegroundColor Red
        Write-Host "Open .\injectscan_data\$fn for more details." -ForegroundColor Red
    }
}
