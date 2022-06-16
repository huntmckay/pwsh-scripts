$ad_block = {
    (Get-ADComputer -Filter * | Select-Object *),(Get-ADUser -Filter * | Select-Object *)
}

$results = Invoke-Command -ComputerName $target -Credential (Get-Credential) -ScriptBlock $ad_block

$epoch = [Math]::Floor([decimal](Get-Date(Get-Date).ToUniversalTime()-uformat "%s"))
$dn = "$epoch`_$target`_AD"

$results[0] | ConvertTo-Json | Out-File $dn\ad_computers.json
$results[1] | ConvertTo-Json | Out-File $dn\ad_users.json
