
# FileName: cst.psm1
# Created Date: 2/25/2022
# Author: Clint Kline
# Purpose: -- A utility to automate common PC Setup tasks.
# THIS PROGRAM MUST BE OPENED IN ADMIN MODE


$currPath = Split-Path -Path $PSScriptRoot
Write-Host "Current Filepath: $currPath"
# powershell.exe Set-ExecutionPolicy AllSigned -Scope LocalMachine
# powershell.exe Set-ExecutionPolicy AllSigned -Scope CurrentUser
powershell.exe Set-ExecutionPolicy AllSigned -Scope Process


#------------------------------
# IMPORT MODULES (SWITCHBOARD)
#------------------------------
Write-Host "MODULES: "

# RenamePC Module
Get-Item -Path $currPath\SetupTool\RenamePC
Import-Module $currPath\SetupTool\RenamePC\RenamePC.psm1

# SetPassword Module
Get-Item -Path $currPath\SetupTool\CreatePassword
Import-Module $currPath\SetupTool\CreatePassword\CreatePassword.psm1

# RenameFullName Module
Get-Item -Path $currPath\SetupTool\RenameFullName
Import-Module $currPath\SetupTool\RenameFullName\RenameFullName.psm1

# PrivateNetworkToggle Module
Get-Item -Path $currPath\SetupTool\PrivateNetworkToggle
Import-Module $currPath\SetupTool\PrivateNetworkToggle\PrivateNetworkToggle.psm1

# PowerSaver Module
Get-Item -Path $currPath\SetupTool\PowerSaver
Import-Module $currPath\SetupTool\PowerSaver\PowerSaver.psm1

# # NumLockToggle Module
Get-Item -Path $currPath\SetupTool\NumLockToggle
Import-Module $currPath\SetupTool\NumLockToggle\NumLockToggle.psm1

# # IPv6Off Module
# Get-Item -Path $currPath\SetupTool\IPv6Off
# Import-Module $currPath\SetupTool\IPv6Off\IPv6Off.psm1

# # Display125 Module
# Get-Item -Path $currPath\SetupTool\Display125
# Import-Module $currPath\SetupTool\Display125\Display125.psm1

# DisableUAC Module
Get-Item -Path $currPath\SetupTool\DisableUAC
Import-Module $currPath\SetupTool\DisableUAC\DisableUAC.psm1


#-----------------------------------
# GLOBAL Variables
#-----------------------------------

# create a list to make the options above 
# easily accessible to a switch statement.
$count = 1
# create an empty list that will contain the users choices
$choiceList = New-Object Collections.Generic.List[int]


#---------------------------
# FRONTPAGE
#---------------------------
#  TITLE
Write-Host "`r`n"
Write-Host "-----------------------------"
Write-Host "Clints Pc Setup Tools"
Write-Host "-----------------------------"
Write-Host "`r`n"

# display available options
Write-Host " 1. Change PC Name" #check
Write-Host " 2. Change PC Fullname" #check
Write-Host " 3. Set PC's Password" #check
Write-Host " 4. Set Network to Private" #check
Write-Host " 5. Make NumLock Default ON"
Write-Host " 6. Disable User Account Control" #working but wonky
Write-Host " 7. Turn PowerSaving ON"
Write-Host " 8. Turn IPv6 OFF"
Write-Host " 9. Resize Display to 125%"
Write-Host "10. All"
Write-Host "11. Open an elevated cmd" #check
Write-Host "`r`n"


#-------------------------------
# Set-Options
#-------------------------------
    
function Set-Options($choiceList) {
        
    # for each choice in the $choiceList array, 
    # assign a phrase to a shared Variable
    foreach ($i in $choiceList) {        

        # if the list isnt empty or equal to 0
        if (($null -ne $i) -Or ($i -ne 0)) {
            Switch ($i) {
                
                1 {
                    $desc = "Beginning Task>> Change PC Name"
                    Write-Host "`r`n"
                    Write-Host $desc 
                    # call Rename-PC function from module
                    RenamePC
                }
                2 {
                    $desc = "Beginning Task>> Change PC FullName"
                    Write-Host "`r`n" 
                    Write-Host $desc 
                    # call Rename-Domain function
                    Write-Host "This one isnt ready yet."
                    FNameWarning
                }
                3 {
                    $desc = "Beginning Task>> Set A New UN & Password"
                    Write-Host "`r`n" 
                    Write-Host $desc 
                    # call SetPassword function from module
                    CreatePassword
                }
                4 {
                    $desc = "Beginning Task>> Private Network"
                    Write-Host "`r`n" 
                    Write-Host $desc 
                    PrivateNetworkToggle
                }
                5 {
                    $desc = "Beginning Task>> NumLock ON"
                    Write-Host "`r`n" 
                    Write-Host $desc 
                    NumLockToggle                    
                }
                6 {
                    $desc = "Beginning Task>> Diable UAC" 
                    Write-Host "`r`n"
                    Write-Host $desc 
                    DisableUAC
                }
                7 {
                    $desc = "Beginning Task>> PWRSVR ON" 
                    Write-Host "`r`n"
                    Write-Host $desc 
                    PowerSaver
                }
                8 {
                    $desc = "Beginning Task>> IPv6 OFF" 
                    Write-Host "`r`n"
                    Write-Host $desc 
                    
                }
                9 {
                    $desc = "Beginning Task>> Display 125%" 
                    Write-Host "`r`n"
                    Write-Host $desc 
                    
                }
                10 {
                    $desc = "Beginning Tasks>> All of 'em" 
                    Write-Host "`r`n"
                    Write-Host $desc 
                    
                }
                11 {
                    $desc ="elevating... "
                    Write-Host "`r`n"
                    Write-Host $desc
                    elevateCmd
                }
                Default {'...that is some invalid input'}
                
            }
        }
        # otherwise report the list as empty and go back to the beginning of the program 
        else {
            Write-Host "The list was empty. going back.. "
            Get-Options($choiceList)
        }
    }

        
}
 
#--------------------------------------------
# Get-Options
#--------------------------------------------

# create a function that will collect the users options and 
# add each on the the $choiceList
function Get-Options($choiceList) {
    #  ask user which tool they would like to use
    $choice = Read-Host -prompt "Tool $count"
    
    # if the list is empty
    if ($null -eq $choiceList) {
        #  tell the user
        Write-Host "$choiceList is null..."
        Set-Options($choiceList)
    }
    # if the value is empty, send the list to the Set-Options function
    elseif (($null -eq $choice) -Or ($choice -eq 0) -Or ($choice -eq '')) {
        Write-Host $nl
        Write-Host ">> Completing Tasks... $nl"
        Set-Options($choiceList)
    }
    # if the value is already in the list
    elseif ($choiceList -contains $choice) {
        Write-Host "That one's already in the list."
        Get-Options($choiceList)
    }
    # if the value is not already in the list
    elseif ($choicelist -notcontains $choice) {
        # increment Tool #
        $count = $count + 1
        # add value to the list of choices
        $choicelist.Add($choice)
        # recurse to the Get-Options function
        Get-Options($choiceList) 
    }
    else {
        Write-Host "Please enter a valid option."
        Get-Options($choiceList)
    }

    # line-break
    Write-Host $nl
}

#--------------------------------------------
# ELEVATE COMMAND
#--------------------------------------------

# open an elevated command prompt with powershell
function elevateCmd() {
    Start-Process cmd -verb runas
}

# initiate the program
Get-Options($choiceList)
$again = Read-Host "Would you like to run the program again? (y/n) >>"

if ($again.toUpper -eq 'Y') {
    Get-Options($choiceList)
}
else {
    Write-Host "The program has ended"
    Start-Sleep -Seconds 3.0
    Exit
}

# Uncomment to automatically restart the PC when the program is finished
# Restart-Computer -Force
    
