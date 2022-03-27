
# FileName: PowerSaver.psm1
# Created Date: 3/13/2022
# Author: Clint Kline
# Purpose: -- A utility to automate making numlock default on.

function PowerSaver() {

    # Set monitor ac timout to 5 minutes
    powercfg /change monitor-timeout-ac 5
    # Set monitor dc timout to 5 minutes
    powercfg /change monitor-timeout-dc 5
    # Set disk ac timout to 5 minutes
    powercfg /change disk-timeout-ac 5
    # Set disk dc timout to 5 minutes
    powercfg /change disk-timeout-dc 5
    # Set standby ac timout to 5 minutes
    powercfg /change standby-timeout-ac 5
    # Set standby dc timout to 5 minutes
    powercfg /change standby-timeout-dc 5
    # Set hibernate ac timout to 5 minutes
    powercfg /change hibernate-timeout-ac 5
    # Set hibernate dc timout to 5 minutes
    powercfg /change hibernate-timeout-dc 5

    #Get the currently active power scheme  
    $Query = powercfg.exe /getactivescheme  
    #Get the alias name of the active power scheme  
    $ActiveSchemeName = ($Query.Split("()").Trim())[1]  
    #Get the GUID of the active power scheme  
    $ActiveSchemeGUID = ($Query.Split(":(").Trim())[1] 


    Write-Host "`r`n`r`n"
    Write-Host "Power Plan set to 'Power Saver'"

}
# make module exportable
Export-ModuleMember -Function PowerSaver





#--------------------------------
# UNUSED CODE
#--------------------------------

# # powercfg /setacvalueindex 961cc777-2547-4f9d-8174-7d8618-1b8a7a
# powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
# # PwerSaver powerscheme for batterysaver 961cc777-2547-4f9d-8174-7d86181b8a7a
# Set-Item -Path HKLM\SYSTEM\ControlSet001\Control\Power\User\PowerSchemes\ActiveOverlayAc/DcPowerScheme
# $computerName = (Get-CimInstance -ClassName Win32_ComputerSystem).Name
# Invoke-Command -ComputerName $computerName  -ScriptBlock {reg add "HKLM\SYSTEM\ControlSet001\Control\Power\User\PowerSchemes\ActiveOverlayAc/DcPowerScheme" }