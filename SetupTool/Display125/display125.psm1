

# FileName: display125.psm1
# Created Date: 3/22/2022
# Author: Clint Kline
# Purpose: -- A utility to automate making the display scale to 125%.


function display125() {

    Write-Output "`n`r"
    Write-Output "Task >> Set Display Resolution : 125%"
    Write-Output "`n`r"

    cd 'HKCU:\Control Panel\Desktop'
    $val = Get-ItemProperty -Path . -Name "LogPixels"

    # set display to 100%
    # if($val.LogPixels -ne 92) {
    #     Write-Host 'Changing to 100% / 92 dpi'
    #     Set-ItemProperty -Path . -Name LogPixels -Value 92
    # } else {
    #     Write-Host 'Youre already at 100%'
    # }

    # set display to 125%
    if($val.LogPixels -ne 120) {
        Write-Host '>> Changing to 125% / 120 dpi'
        Set-ItemProperty -Path . -Name LogPixels -Value 120
    } else {
        Write-Host '>> Youre already at 125%'
    }

    # set display to 150%
    # if($val.LogPixels -ne 144) {
    #     Write-Host 'Changing to 150% / 144 dpi'
    #     Set-ItemProperty -Path . -Name LogPixels -Value 144
    # } else {
    #     Write-Host 'Youre already at 150%'
    # }

}

Write-Host "`r`n`r`n"
# make module exportable
Export-ModuleMember -Function display125