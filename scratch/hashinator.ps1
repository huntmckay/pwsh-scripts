#File hasing can the baseline of integritiy on core files
#should probably find a way to collect/hash a giant list of files for diffing
Get-FileHash $FILENAME -Algorithm MD5|SHA256
