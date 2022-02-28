
# FileName: clintsSetupTools.ps1
# Created Date: 2/25/2022
# Author: Clint Kline
# Purpose: -- A utility to automate common PC Setup tasks.


#------------------------------
# IMPORT MODULES
#------------------------------
Write-Output "MODULES: "

# RenamePC Module
Get-Item -Path .\RenamePC
Import-Module .\RenamePC\RenamePC.psm1

# SetPassword Module
Get-Item -Path .\CreatePassword
Import-Module .\CreatePassword\CreatePassword.psm1

# RenameFullName Module
Get-Item -Path .\RenameFullName
Import-Module .\RenameFullName\RenameFullName.psm1


#-----------------------------------
# GLOBAL Variables
#-----------------------------------
# create a variable to act as a newline character
$nl = [Environment]::NewLine

# create a list to make the options above 
# easily accessible to a switch statement.
$count = 1
# create an empty list that will contain the users choices
$choiceList = New-Object Collections.Generic.List[int]


#---------------------------
# FRONTPAGE
#---------------------------

Write-Output $nl
Write-Output "-----------------------------"
Write-Output "Clints Pc Setup Tools"
Write-Output "-----------------------------"

# display available options
Write-Output "$nl 1. Change PC Name"
Write-Output " 2. Change PC Fullname"
Write-Output " 3. Set PC's Password"
Write-Output " 4. Set Network to Private"
Write-Output " 5. Make NumLock Default ON"
Write-Output " 6. Disable User Account Control"
Write-Output " 7. Turn PowerSaving ON"
Write-Output " 8. Turn IPv6 OFF"
Write-Output " 9. Resize Display to 125%"
Write-Output "10. All"
Write-Output "$nl"


#-------------------------------
# Set-Options
#-------------------------------
    
function Set-Options($choiceList) {
        
    # for each choice in the $choiceList array, 
    # assign a phrase to a shared Variable

    foreach ($i in $choiceList) {        

        if (($null -ne $i) -Or ($i -ne 0)) {
            Switch ($i) {
                
                1 {
                    $desc = "Beginning Task>> Change PC Name"
                    Write-Output $desc 
                    # call Rename-PC function from module
                    RenamePC
                }
                2 {
                    $desc = "Beginning Task>> Change PC FullName" 
                    Write-Output $desc 
                    # call Rename-Domain function
                    Write-Output "This one isnt ready yet."
                    FNameWarning

                }
                3 {
                    $desc = "Beginning Task>> Set A New UN & Password" 
                    Write-Output $desc 
                    # call SetPassword function from module
                    CreatePassword
                    
                }
                4 {
                    $desc = "Beginning Task>> Private Network" 
                    Write-Output $desc 
                    
                }
                5 {
                    $desc = "Beginning Task>> NumLock ON" 
                    Write-Output $desc 
                    
                }
                6 {
                    $desc = "Beginning Task>> Diable UAC" 
                    Write-Output $desc 
                    
                }
                7 {
                    $desc = "Beginning Task>> PWRSVR ON" 
                    Write-Output $desc 
                    
                }
                8 {
                    $desc = "Beginning Task>> IPv6 OFF" 
                    Write-Output $desc 
                    
                }
                9 {
                    $desc = "Beginning Task>> Display 125%" 
                    Write-Output $desc 
                    
                }
                10 {
                    $desc = "Beginning Tasks>> All of 'em" 
                    Write-Output $desc 
                
                }
                Default {'...that is some invalid input'}

            }
            
            
        }

        
    }
 

}

#--------------------------------------------
# Get-Options
#--------------------------------------------

# create a function that will collect the users options and 
# add each on the the $choiceList
function Get-Options($choiceList) {

    $choice = Read-Host -prompt "Tool $count"
    
    # if the list is empty
    if ($null -eq $choiceList) {
        Write-Output "$choiceList is null..."
    }
    # if the value is empty, send the list to the Set-Options function
    elseif (($null -eq $choice) -Or ($choice -eq 0) -Or ($choice -eq '')) {
        Write-Output $nl
        Write-Output ">> Completing Tasks... $nl"
        Set-Options($choiceList)
    }
    # if the value isnt empty, add it to the list
    elseif ($choiceList -contains $choice) {
        Write-Output "That one's already in the list."
        Get-Options($choiceList)
    }
    elseif ($choicelist -notcontains $choice) {
        # increment Tool #
        $count = $count + 1
        # add the most recent choice to the list of choices
        $choicelist.Add($choice)
        # recurse to the Get-Options function
        Get-Options($choiceList) 
    }
    else {
        Write-Output "Please enter a valid option."
        Get-Options($choiceList)
    }
    
    Write-Output $nl
}

Get-Options($choiceList)
    
    
