# Shows all Data Streams
Get-Item $output -Stream *

#This will show the different stream types on the NFTS system
Get-Item $output -Stream * | where Stream -ne ':$DATA'

#view specific ADS
Get-Content $output -Stream SoupDuJour
