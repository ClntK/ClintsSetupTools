
# FileName: NetworkFunctions.psm1
# Created Date: 3/8/2022
# Author: Clint Kline
# Purpose: -- A PS Module to automate setting a network to private


#--------------------------------------------------------------------------------------------------------------------------

# select a fucntion to perform on a network
Write-Output "`n`r"
Write-Output ">>> Select an action to perform"
Write-Output "`n`r"

# ----------------------------------------
# FUNCTION TO SET A NETWORK TO PRIVATE
# ----------------------------------------

function PrivateNetworkToggle($network) {

    Write-Output "`n`r"
    Write-Output "Task >> Private Network Toggle"
    Write-Output "`n`r"

    # toggle network to private
    Set-NetConnectionProfile -InterfaceAlias $network -NetworkCategory 'Private'
    Write-Host "`r`n"
    $network + "'s network category now set to private."
}
# make module exportable
Export-ModuleMember -Function PrivateNetworkToggle

#--------------------------------------------------------------------------------------------------------------------------

# -----------------------------------
# FUNCTION TO RENAME A NETWORK
# -----------------------------------

function RenameNetwork() {

    Write-Output "`n`r"
    Write-Output "Task >> Rename a Network"
    Write-Output "`n`r"

    # create an object to contain a list of active networks 
    $adapterList = (Get-CimInstance -Class Win32_NetworkAdapter -Property NetConnectionID,NetConnectionStatus | Where-Object { $_.NetConnectionStatus -eq 2 } | Select-Object -Property NetConnectionID -ExpandProperty NetConnectionID)
    # print list of adapters
    Write-Host $adapterList

    # ask user which network they want to rename
    $oldAdapterName = Read-Host "Which network would you like to rename?"
    
    # if a network with that name exists
    if (Get-NetAdapter -Name $oldAdapterName) {

        $newAdapterName = Read-Host "What would you like to rename the network?"
        # line to select the adapter
        Get-NetAdapter -Name $oldAdapterName | Rename-NetAdapter -NewName $newAdapterName
    } else {
        Write-Host "No networks with that name exist. Try again."
        RenameNetwork
    }

}
# make module exportable
Export-ModuleMember -Function RenameNetwork

#--------------------------------------------------------------------------------------------------------------------------

# -----------------------------------
# FUNCTION TO SELECT A NETWORK
# -----------------------------------

function SelectNetwork() {

    Write-Output "`n`r"
    Write-Output "Task >> Select a Network"
    Write-Output "`n`r"

    # create an object to contain a list of active networks 
    $adapterList = (Get-CimInstance -Class Win32_NetworkAdapter -Property NetConnectionID,NetConnectionStatus | Where-Object { $_.NetConnectionStatus -eq 2 } | Select-Object -Property NetConnectionID -ExpandProperty NetConnectionID)
    
    # if $adapterList isnt empty
    if ($adapterList) {
    
        # print the list of adapters
        $adapterList

        # ask user which network they want to make private
        $AdapterName = Read-Host "Which network would you like to select?"
        
        # if a network with that name exists, select adapter
        if (Get-NetAdapter -Name $AdapterName) {

            PrivateNetworkToggle($AdapterName)

        } else {
            Write-Host "No networks with that name exist. Try again."
            # try again
            SelectNetwork
        }
    } else {
        Write-Host "`r`n"
        Write-Output "There are currently NO CONNECTED NETWORK adapters on this device."
    }

}

Write-Host "`r`n`r`n"
# make module exportable
Export-ModuleMember -Function SelectNetwork

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

