
# FileName: cst.psm1
# Created Date: 2/25/2022
# Author: Clint Kline
# Purpose: -- A utility to automate common PC Setup tasks.
# THIS PROGRAM MUST BE OPENED IN ADMIN MODE

# create a variable to hold the filepath of this file.
$filepath = Split-Path -Path $PSScriptRoot
Write-Host "Current Filepath: $filepath"

# execution policies: undefined, unrestricted, restricted, remotesigned,
# scopes: MachinePolicy, UserPolicy, Process, CurrentUser, LocalMachine
powershell.exe Set-ExecutionPolicy AllSigned -Scope Process

#-----------------------------------
# GLOBAL Variables
#-----------------------------------

# create a list to make the options above 
# easily accessible to a switch statement.
$toolcount = 1
# create an empty list that will contain the users choices
$choiceList = New-Object Collections.Generic.List[int]


#------------------------------------------------------------------------------------------
# FUNCTIONS
# FUNCTIONS
#------------------------------------------------------------------------------------------


#------------------------------
# IMPORT MODULES (SWITCHBOARD)
#------------------------------
function ImportModules() {

    Write-Host "MODULES: "

    # RenamePC Module
    Get-Item -Path $filepath\SetupTool` Merge\RenamePC
    Import-Module $filepath\SetupTool` Merge\RenamePC\RenamePC.psm1

    # SetPassword Module
    Get-Item -Path $filepath\SetupTool` Merge\CreatePassword
    Import-Module $filepath\SetupTool` Merge\CreatePassword\CreatePassword.psm1

    # RenameDomain Module
    Get-Item -Path $filepath\SetupTool` Merge\RenameDomain
    Import-Module $filepath\SetupTool` Merge\RenameDomain\RenameDomain.psm1

    # NetworkFunctions Module
    Get-Item -Path $filepath\SetupTool` Merge\NetworkFunctions
    Import-Module $filepath\SetupTool` Merge\NetworkFunctions\NetworkFunctions.psm1

    # PowerSaver Module
    Get-Item -Path $filepath\SetupTool` Merge\PowerSaver
    Import-Module $filepath\SetupTool` Merge\PowerSaver\PowerSaver.psm1

    # # NumLockToggle Module
    Get-Item -Path $filepath\SetupTool` Merge\NumLockToggle
    Import-Module $filepath\SetupTool` Merge\NumLockToggle\NumLockToggle.psm1

    # # IPv6Off Module
    Get-Item -Path $filepath\SetupTool` Merge\IPv6Off
    Import-Module $filepath\SetupTool` Merge\IPv6Off\IPv6Off.psm1

    # Display125 Module
    Get-Item -Path $filepath\SetupTool` Merge\Display125
    Import-Module $filepath\SetupTool` Merge\Display125\Display125.psm1

    # DisableUAC Module
    Get-Item -Path $filepath\SetupTool` Merge\DisableUAC
    Import-Module $filepath\SetupTool` Merge\DisableUAC\DisableUAC.psm1

} ImportModules

#--------------------------------------------
# Set-Options
#--------------------------------------------
    
function Set-Options($choiceList) {

    if (!$choiceList) {
        Write-Host "`n>> The tool list is empty.`n"
        ReRun
    }
    else {    
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
                        # call RenamePC function from module
                        RenamePC
                    }
                    2 {
                        $desc = "Beginning Task>> Rename Domain"
                        Write-Host "`r`n"
                        Write-Host $desc 
                        # call RenameDomain function through Confirm-RenameDomain module
                        Confirm-RenameDomain
                    }
                    3 {
                        $desc = "Beginning Task>> Create a New User"
                        Write-Host "`r`n" 
                        Write-Host $desc 
                        # call SetPassword function from module
                        NewUser
                    }
                    4 {
                        $desc = "Beginning Task>> Reset Password"
                        Write-Host "`r`n" 
                        Write-Host $desc 
                        # call ResetPassword function from module
                        ResetPassword
                    }
                    5 {
                        $desc = "Beginning Task>> Private Network"
                        Write-Host "`r`n" 
                        Write-Host $desc 
                        # call NetworkFunctions function from module
                        NetworkFunctions                    
                    }
                    6 {
                        $desc = "Beginning Task>> NumLock ON"
                        Write-Host "`r`n" 
                        Write-Host $desc
                        # call NumLockToggle function from module 
                        NumLockToggle
                    }
                    7 {
                        $desc = "Beginning Task>> Diable UAC" 
                        Write-Host "`r`n"
                        Write-Host $desc
                        # call DisableUAC function from module 
                        DisableUAC
                    }
                    8 {
                        $desc = "Beginning Task>> PWRSVR ON" 
                        Write-Host "`r`n"
                        Write-Host $desc
                        # call PowerSaver function from module 
                        PowerSaver
                    }
                    9 {
                        $desc = "Beginning Task>> IPv6 OFF" 
                        Write-Host "`r`n"
                        Write-Host $desc
                        # call IPv6OFF function from module 
                        IPv6OFF
                    }
                    10 {
                        $desc = "Beginning Task>> Display 125%" 
                        Write-Host "`r`n"
                        Write-Host $desc
                        # call Display125 function from module 
                        Display125                        
                    }
                    11 {
                        $desc = "Beginning Tasks>> All of 'em" 
                        Write-Host "`r`n"
                        Write-Host $desc
                        # call AllOfEm function from module 
                        AllOfEm
                    12 {
                        $desc =">> Elevating..."
                        Write-Host "`r`n"
                        Write-Host $desc
                        # call ElevateCmd function from module
                        ElevateCmd
                    }
                    }
                    Default { Write-Host "...that is some invalid input", ReRun }
                    
                } 
            }
        } ReRun
    }
}
 
#--------------------------------------------
# Get-Options
#--------------------------------------------
# create a variable to count the number of tool that have been selected
# $toolcount = 1


# create a function that will collect the users options and 
# add each on the the $choiceList
function Get-Options($choiceList) {

    # ask user which tool they would like to use
    $choice = Read-Host -prompt ">> Tool $toolcount"
    
    if ((!$choice) -Or ($choice -eq 0) -Or ($choice -eq '')) {
        Set-Options($choiceList)
    }
    # if the value is already in the list
    elseif ($choiceList -contains $choice) {
        Write-Host ">> That one's already in the list."
        Get-Options($choiceList)
    }
    # if the value is not already in the list
    elseif ($choicelist -notcontains $choice) {
        # increment Tool #
        $toolcount = $toolcount + 1
        # add value to the list of choices
        $choicelist += $choice
        # recurse to the Get-Options function
        Get-Options($choiceList) 
    }
    else {
        Write-Host ">> Please choose at least one tool from the list: `n"
        Get-Options($choiceList) 
    }
    # line-break
    Write-Host `n`r

}

#---------------------------------
# OPEN ADMIN PROMPT
#---------------------------------

function ElevateCmd() {
    Start-Process cmd -verb runas
}

#--------------------------------------------
# RERUN COMMAND
#--------------------------------------------

function ReRun() {
    # as user if they want to start again from the beginning
    $again = Read-Host -prompt "`nWould you like to run the program again? (y/n) >>"

    # accept y or n for input, y restarts, n exits
    if ($again.ToUpper() -eq 'Y') {

        # reset the toolcount variable
        $toolcount = 1
        #make sure the $choiceList is empty
        $choiceList = @()
        
        Write-Host `n
        Get-Options($choiceList)\

    }
    elseif ($again.ToUpper() -eq 'N') {
        ExitFunc        
    }
    else {
        Write-Output ">> Please enter 'y' or 'n'..."   
    }
}

#--------------------------------------------
# EXIT PROGRAM
#--------------------------------------------

function ExitFunc() {

    Write-Output `n`r
    Write-Output ">> Ok."
    Write-Output `n`r
    Write-Host ">> The program will end."
    Start-Sleep -Seconds 2.0
    Write-Output ">> Goodbye."
    Start-Sleep -Seconds 1.0
    Exit
       
}

#--------------------------------------------
# RESTART COMMAND
#--------------------------------------------

function AskToRestart() {
    
    $restart = Read-Host -prompt "Would you like to RESTART the computer? (y/n) >>"
            
            if ($restart.ToUpper() -eq 'Y') {
                Write-Output `n`r
                Write-Output "Yes."
                RestartPC
            }
            elseif ($restart.ToUpper() -eq 'N') {
                ExitFunc
            }
            else {
                Write-Output ">> Please enter 'y' or 'n'..."   
            }
}

function RestartPC() {

    $restart = Read-Host "Are you sure? (y/n) >>"

    if ($restart.ToUpper() -eq 'Y') {
        Restart-Computer -Force
    }
    elseif ($restart.ToUpper() -eq 'N') {
        Write-Output "You said no..."
        ReRun        
    }
    else {
        Write-Output "Please enter 'y' for yes or 'n' for no..."   
    }

}

#---------------------------------------------------------------------------------------------------------------------------------------
# LAUNCH PROGRAM
#---------------------------------------------------------------------------------------------------------------------------------------
#---------------------------

function LaunchPad() {

    #  TITLE
    Write-Host "`r`n"
    Write-Host "-----------------------------`n"
    Write-Host "Clints Pc Setup Tools`n"
    Write-Host "-----------------------------"
    Write-Host "`r`n"

    # display available options
    Write-Host " 1. Change PC Name" 
    Write-Host "`n 2. Change Domain Name" 
    Write-Host "`n 3. Create New User"     
    Write-Host "`n 4. Reset User Password"     
    Write-Host "`n 4. Set Current Network to Private" 
    Write-Host "`n 5. Numlock Default ON at Startup"
    Write-Host "`n 6. Disable User Account Control"
    Write-Host "`n 7. Turn PowerSaving ON"
    Write-Host "`n 8. Disable IPv6 on the Current Network"
    Write-Host "`n 9. Set Display Scale : 125%"
    Write-Host "`n10. Complete All"
    Write-Host "`n11. Open Eleveated CMD Prompt" 
    Write-Host "`n`r`n"

    Write-Host "----------------------------------------------------------------------------"
    Write-Host "`n>> Instructions: Enter the numbers of the tasks you would like to complete.`n"
    Write-Host "----------------------------------------------------------------------------`n`n"

    # INITIATION COMMAND
    # initiate the program
    Get-Options($choiceList)

} LaunchPad
