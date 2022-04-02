
# FileName: PrivateNetworkToggle.psm1
# Created Date: 3/8/2022
# Author: Clint Kline
# Purpose: -- A PS Module to automate setting a network to private


function PrivateNetworkToggle() {

    # create a variable to contain a list of active networks 
    $adapterName = (Get-CimInstance -Class Win32_NetworkAdapter -Property NetConnectionID,NetConnectionStatus | Where-Object { $_.NetConnectionStatus -eq 2 } | Select-Object -Property NetConnectionID -ExpandProperty NetConnectionID)
    # if $adapterName isnt empty
    if ($adapterName) {
        # instantiate it
        $adapterName
        # ask user if their target network is in the list
        $confirm = Read-Host "Does this list contain the network you're looking for? "
        Write-Host "`r`n"
        
        if ($confirm.ToUpper() -eq 'Y') {
            # select first network in connection list >> gonna have to make this better later
            $network = $adapterName[0]
            # toggle network to private
            Set-NetConnectionProfile -InterfaceAlias $network -NetworkCategory 'Private'
            Write-Host "`r`n"
            $network + "'s network category now set to private."
        }
        else {
            Write-Host "`r`n"
            Write-Output "Well Dang."
        }
    }
    else {
        Write-Host "`r`n"
        Write-Output "There are currently NO CONNECTED NETWORK adapters on this device."
    }
}

Write-Host "`r`n`r`n"
# make module exportable
Export-ModuleMember -Function PrivateNetworkToggle

#-----
# Q's
#-----

# how do i execute this code inside of an admin shell through cmd automatically?



# ----------------------------------
# PROTO LINES 
#-----------------------------------
# a line to accept user input as network name
    # $network = Read-Host "Please enter the name of the network you'd like to set to private"
# an if statement that tries to set the user entered network to private if it exists
    # if (Set-NetConnectionProfile -Name $network -Networkcategory "private") {
# use wmi to get info on all network connections
    # get-wmiobject win32_networkadapter -filter "netconnectionstatus = 2" |
    # >>
    # >> select netconnectionid, name, InterfaceIndex, netconnectionstatus