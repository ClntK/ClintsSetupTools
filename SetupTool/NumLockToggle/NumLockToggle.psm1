
# FileName: NumLockToggle.psm1
# Created Date: 3/13/2022
# Author: Clint Kline
# Purpose: -- A utility to automate making numlock default on.

function NumLockToggle() {

    Set-ItemProperty -Path 'Registry::HKU\.DEFAULT\Control Panel\Keyboard' -Name "InitialKeyboardIndicators" -Value "2"
    Write-Output "`r`n`r`nDefault Num-Lock on."

}
# make module exportable
Export-ModuleMember -Function NumLockToggle
