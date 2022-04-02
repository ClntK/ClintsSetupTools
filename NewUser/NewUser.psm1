# FileName: SetPassword.psm1
# Created Date: 2/27/2022
# Author: Clint Kline
# Purpose: -- A PS Module to automate Setting a PC's Password

# !!! THIS FILE IS NOT YET FULLY TESTED.
# !!! EXECUTE ON VM OR AT YOUR OWN RISK.

#----------------------------
#  SetUNPW
#----------------------------

function SetUNPW {

    $confirmCreate = Read-Host ""
    Write-Output `n
    $UserName = Read-Host "Enter a User Name"
    $Password = Read-Host -AsSecureString "Enter a Password"
    
    Set-LocalUser -Name $UserName -Password $Password

    Write-Output "UserName has been set to $UserName"
    Write-Output "Password has been set to $Password"
}


Write-Host "`r`n`r`n"
# make module exportable
Export-ModuleMember -Function SetUNPW