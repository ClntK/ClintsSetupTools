

# FileName: IPv6OFF.psm1
# Created Date: 3/24/2022
# Author: Clint Kline
# Purpose: -- A utility to automate turning off IPv6.

# Write-Host 'OS Supports IPv6: ' $( [System.Net.Sockets.Socket]::OSSupportsIPv6 )


function IPv6OFF() {

    Write-Output "`n`r"
    Write-Output "Task >> Turn IPv6 Off"
    Write-Output "`n`r"
        
    # create an object to contain a list of active networks 
    $AdapterList = (Get-CimInstance -Class Win32_NetworkAdapter -Property NetConnectionID,NetConnectionStatus | Where-Object { $_.NetConnectionStatus -eq 2 } | Select-Object -Property NetConnectionID -ExpandProperty NetConnectionID)
    
    # if $AdapterList isnt empty
    if ($null -ne $AdapterList) {

        Write-Host "NETWORK ADAPTERS:"
        Write-Host "-----------------"
        Write-Host "`n`r"

        # print the list of adapters
        $AdapterList
        Write-Host "`n`r"

        # ask user which network they want to make private
        $AdapterName = Read-Host "Which network would you like to select? (leave empty to skip)"

        # if the prompt is left empty
        if (!$AdapterName) {

            Write-Host "Skipping... "

        } else {
            # if the network exists / is spelled correctly
            if ((Get-NetAdapter -Name $AdapterName)) {
                # if OS and netadapters support IPv6
                if (([System.Net.Sockets.Socket]::OSSupportsIPv6) -eq $true) {
                    # disable IPv6
                    Disable-NetAdapterBinding –InterfaceAlias $networkName –ComponentID ms_tcpip6
                    Write-Host ">> IPv6 is now OFF."
                # if they do not
                } elseif (([System.Net.Sockets.Socket]::OSSupportsIPv6) -eq $false) {
                    Write-Host ">> IPv6 is already off."
                }    
            } else {
                Write-Host ">> That network doesnt exist. Be sure to check spelling then try again.."
                IPv6OFF
            }
        }

    } else {
        Write-Host "`n`r>> There are no network adapters available.."
    }
}

Write-Host "`r`n`r`n"
# make module exportable
Export-ModuleMember -Function IPv6OFF

## if the network name exists
# $interfaces = Get-WmiObject Win32_NetworkAdapter
# $interfaces | foreach {
#     $friendlyname = $_ | Select-Object -ExpandProperty NetConnectionID
#     $name = $_.GetRelated("Win32_PnPEntity") | Select-Object -ExpandProperty Name
#     "$friendlyname is $name"
# }