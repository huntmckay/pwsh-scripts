Get-AuthenticodeSignature *




(get-process | select path -unique).name|foreach{ Get-AuthenticodeSignature $_ } | where-object Status -ne Valid
