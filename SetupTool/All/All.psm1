

# FileName: All.psm1
# Created Date: 3/34/2022
# Author: Clint Kline
# Purpose: -- A utility to automate perfoming all available tasks.


function All() {

    RenamePC
    FNameWarning
    CreatePassword
    PrivateNetworkToggle
    NumLockToggle
    DisableUAC
    Powersaver
    IPv6OFF
    Display125

}
# make module exportable
Export-ModuleMember -Function All