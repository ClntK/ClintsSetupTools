
# FileName: RenameFullName.psm1
# Created Date: 2/25/2022
# Author: Clint Kline
# Purpose: -- A utility to automate the Renaming of a PCs Domain.

# !!! THIS FILE IS NOT YET FULLY TESTED.
# !!! EXECUTE ON VM OR AT YOUR OWN RISK.

#----------------------
#Rename Domain 
#----------------------

function Confirm-RenameDomain {

    # get the domains current name
    Write-Output ">> PC's Current Domain"

    # check if the computer is a part of a domain
    if ((Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain) {
    
        $renameDom = Read-Host -prompt "`n>> Would you like to rename the Domain? (y/n)"

        if ($renameDom.toUpper() -eq "Y") {            
            Rename-Domain
        }
        elseif ($renameDom.toUpper() -eq "N") {
            Write-Output ">> Rename Cancelled."        
        }
        else {
            Write-Output ">> Please enter 'y' or 'n'..."   
        }
    }
    else {

        Write-Host "This computer is not connected to a domain."
    }
}
Write-Host "`r`n`r`n"
# make module exportable
Export-ModuleMember -Function Confirm-RenameDomain

function Rename-Domain {

    Write-Output ">> Change Domain Name >>" 

    

    # enter the new name
    $newDom = Read-Host -prompt ">> Enter the Domain's new system name"
    $nameChange = $currDom.Rename($newDom)
    Set-MsolDomain -Name $newDom -IsDefault

    #change the name
    if ($nameChange) {
        # confirm name change
        Write-Output ">> Domain name successfully changed"
    }
    # if it wont change
    else {
        Write-Output ">> Domain name Change Unsuccessful"
    }

    # get the Pcs new name
    Write-Output ">> Domain's New Info"
    $currDom = Get-WmiObject Namespace root\cimv2 -Class Win64_ComputerSystem | Select Name, Domain
    # display the Pcs new name
    Write-Output $currDom

}