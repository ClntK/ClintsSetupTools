
# FileName: RenamePC.psm1
# Created Date: 2/27/2022
# Author: Clint Kline
# Purpose: -- A PS Module to automate Renaming a PC


#----------------------
#Rename PC
#----------------------
function RenamePC {

    # get the Pcs current name
    Write-Output "`nPC's Current Info"
    $currName = Get-ComputerInfo -Property CsName.value
    # $currName = Get-ComputerInfo -Property CsDnsHostName
    Write-Output $currName

    # enter the new name
    $renamePC = Read-Host -prompt "`nWould you like to rename the PC? (y/n)"
    
    if (($renamePC -eq "y") -Or ($renamePC -eq "Y")) {
        $newName = Read-Host -prompt "Enter the PCs new name"
        Write-Output `n 
        Rename-Computer -ComputerName $currName -NewName $newName -Confirm -PassThru
        if ($nameChange) {
            Write-Output ".. PC name successfully changed.`n"   
            Write-Output "Action will take effect after Restart..."
        }    
    }
    elseif (($renamePC -eq "n") -Or ($renamePC -eq "N")) {
        # next function
        Write-Output "You said no.`n"
    }
    else {
        Write-Output ".. Name Change Unsuccessful`n"
        Write-Output "Please enter 'y' or 'n'..."
        RenamePC   
    }

    # get the Pcs new name
    # Write-Output $nl
    Write-Output "PC's New Info"
    $currName = Get-ComputerInfo -Property CsName
    Write-Output $currName
    Write-Output `n
    
}

Write-Host "`r`n`r`n"
# make module exportable
Export-ModuleMember -Function RenamePC

