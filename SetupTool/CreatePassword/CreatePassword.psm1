# FileName: SetPassword.psm1
# Created Date: 2/27/2022
# Author: Clint Kline
# Purpose: -- A PS Module to automate Setting a PC's Password

#----------------------------
#  CreatePassword
#----------------------------

function CreatePassword {

    Write-Output "'r'n"
    $UserName = Read-Host "Enter a User Name"
    $Password = Read-Host -AsSecureString "Enter a Password"
    
    Set-LocalUser -Name $UserName -Password $Password

    Write-Output "UserName has been set to $UserName"
    Write-Output "Password has been set to $Password"
}
Export-ModuleMember -Function CreatePassword