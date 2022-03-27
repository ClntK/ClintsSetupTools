# FileName: display125.psm1
# Created Date: 3/22/2022
# Author: Clint Kline
# Purpose: -- A utility to automate making the display scale to 125%.

cd 'HKCU:\Control Panel\Desktop'
$val = Get-ItemProperty -Path . -Name "LogPixels"
if($val.LogPixels -ne 120)
{
    Write-Host 'Changing to 125% / 120 dpi'
    Set-ItemProperty -Path . -Name LogPixels -Value 120
} else {
    Write-Host 'Youre already at 125%'
}