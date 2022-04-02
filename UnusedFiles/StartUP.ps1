
# FileName: StartUP.ps1
# Created Date: 3/13/2022
# Author: Clint Kline
# Purpose: 
# -- A utility to initiate automation of common PC Setup tasks.
# -- this file will act as an execution file on a usb drive
# -- THIS PROGRAM MUST BE OPENED IN ADMIN MODE


# --------------------------------------------
# import CST(clintsetuptools).psm1 OPTION: 
# uncomment if the file is being opened directly from a flash drive
# --------------------------------------------

# Get-Item -Path $currPath\TOOLS\SetupTool\CST
# Import-Module $currPath\TOOLS\SetupTool\CST\cst.psm1

# step 1: 
# where will the usb drive be installed?
# $DRIVE = Read-Host "Enter the Tool's drive letter"

# navigate to usb location 
# $PATH = $DRIVE + ":\TOOLS\SetupTool"
# Write-output $PATH



# open the tool file
cd $Path 
.\cst.psm1
Write-Output ">>> TOOLS INITIATED >>>"


