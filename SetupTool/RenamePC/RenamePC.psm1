
# FileName: RenamePC.psm1
# Created Date: 2/27/2022
# Author: Clint Kline
# Purpose: -- A PS Module to automate Renaming a PC


#----------------------
#Rename PC
#----------------------
function RenamePC {

    # get the Pcs current name
    Write-Output $nl, "PC's Current Info"
    $currName = Get-WmiObject Win32_ComputerSystem
    Write-Output $currName, $nl

    # enter the new name
    $renamePC = Read-Host -prompt "Would you like to rename the PC? (y/n)"
    
    if (($renamePC -eq "y") -Or ($renamePC -eq "Y")) {
        $newName = Read-Host -prompt "Enter the PCs new system name"
        Write-Output $nl
        $nameChange = $currName.Rename($newName)
        if ($nameChange) {
            Write-Output ".. PC name successfully changed$nl"   
            Write-Output "Action will take effect after Restart..."
        }    
    }
    elseif (($renamePC -eq "n") -Or ($renamePC -eq "N")) {
        # next function
        Write-Output "You said no.$nl"
    }
    else {
        Write-Output ".. Name Change Unsuccessful$nl"
        Write-Output "Please enter 'y' or 'n'..."   
    }

    # get the Pcs new name
    # Write-Output $nl
    Write-Output "PC's New Info"
    $currName = Get-WmiObject Win32_ComputerSystem
    Write-Output $currName
    Write-Output $nl
    
}

Export-ModuleMember -Function RenamePC