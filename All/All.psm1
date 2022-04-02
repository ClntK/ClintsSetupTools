

# FileName: All.psm1
# Created Date: 3/24/2022
# Author: Clint Kline
# Purpose: -- A utility to automate perfoming all available tasks.


function All() {

    RenamePC
    DisableUAC
    Display125
    IPv6OFF
    NetworkFunctions
    NewUser
    NumLockToggle
    PowerSaver
    RenameDomain
    RenamePC
    ResetPassword

}

Write-Host "`r`n`r`n"
# make module exportable
Export-ModuleMember -Function All