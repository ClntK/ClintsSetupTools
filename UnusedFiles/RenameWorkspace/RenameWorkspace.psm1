
# FileName: RenameWorkspace.psm1
# Created Date: 4/2/2022
# Author: Clint Kline
# Purpose: -- A utility to automate the Renaming of a PCs Workspace.


#----------------------
#Rename Workspace 
#----------------------

function Confirm-RenameWorkspace {

    # get the Workspaces current name
    Write-Output ">> PC's Current Workspace"
    Write-Output ">> ", Get-WmiObject -Class Win32_ComputerSystem).Workgroup
    
    $renameWS = Read-Host -prompt "`n>> Would you like to rename the Workspace? (y/n)"

    if ($renameWS.toUpper() -eq "Y") {            
        Rename-Workspace
    }
    elseif ($renameWS.toUpper() -eq "N") {
        Write-Output ">> Rename Cancelled."        
    }
    else {
        Write-Output ">> Please enter 'y' or 'n'..."   
    }
    
}
Write-Host "`r`n`r`n"
# make module exportable
Export-ModuleMember -Function Confirm-RenameWorkspace

function Rename-Workspace {

    Write-Output ">> Change Workspace Name >>" 
    # enter the new name
    $newWS = Read-Host -prompt ">> Enter the Workspace's new system name"
    $nameChange = $currWS.Rename($newWS)
    Set-MsolWorkspace -Name $newWS -IsDefault

    #change the name
    if ($nameChange) {
        # confirm name change
        Write-Output ">> Workspace name successfully changed"
    }
    # if it wont change
    else {
        Write-Output ">> Workspace name Change Unsuccessful"
    }

    # get the Pcs new name
    Write-Output ">> Workspace's New Info"
    $currWS = Get-WmiObject Namespace root\cimv2 -Class Win64_ComputerSystem | Select Name, Workspace
    # display the Pcs new name
    Write-Output $currWS

}