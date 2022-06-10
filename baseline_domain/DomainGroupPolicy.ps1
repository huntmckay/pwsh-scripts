Get-ADDefaultDomainPasswordPolicy -Current LoggedOnUser

Get-ADDefaultDomainPasswordPolicy -Current LocalComputer

Get-ADDefaultDomainPasswordPolicy -Identity pclab.com

#GPO cmdlet returns all or one GPO in domain
Get-GPO -all

#need to try this with AD GPO
Get-GPOReport -Name "Wireless Policy" -ReportType Html -Path "$PATH"

#All policies applied to user or computer
Get-GPResultantSetOfPolicy -user $USER -computer $COMPUTER -ReportType Html -path "$PATH"


