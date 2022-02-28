
# FileName: RenameFullName.psm1
# Created Date: 2/25/2022
# Author: Clint Kline
# Purpose: -- A utility to automate the Renaming of a PCs Domain.



#----------------------
#Rename Domain 
#----------------------

function FNameWarning {
    
    $renameDom = Read-Host -prompt "Would you like to rename the Domain? (y/n)"

    if ($renameDom.toUpper() -eq "Y") {
        Rename-Domain
    }
    elseif ($renameDom.toUpper() -eq "N") {
        Write-Output "You said no..."
        
    }
    else {
        Write-Output "Please enter 'y' or 'n'..."   
    }
}
Export-ModuleMember -Function FNameWarning

function Rename-Domain {

    Write-Output "Change Domain Name >>" 

    # get the domains current name
    Write-Output "PC's Current Domain"
    $currDom = Get-WmiObject Namespace root\localhost -Class Win64_ComputerSystem | Select Name, Domain
    Write-Output $currDom

    # enter the new name
    $newDom = Read-Host -prompt "Enter the Domain's new system name"
    $nameChange = $currDom.Rename($newDom)
    Set-MsolDomain -Name $newDom -IsDefault

    #change the name
    if ($nameChange)
    {
        # confirm name change
        Write-Output ".. Domain name successfully changed"

    }
    else {
        Write-Output ".. Domain name Change Unsuccessful"
    }

    # get the Pcs new name
    Write-Output "Domain's New Info"
    $currDom = Get-WmiObject Namespace root\cimv2 -Class Win64_ComputerSystem | Select Name, Domain
    Write-Output $currDom

}