 set-location 'HKCU:\Control Panel\Desktop'

 $val = Get-ItemProperty -Path . -Name "LogPixels"

 if($val.LogPixels -ne 120) 
 {
    write-host 'Change to 125% / 120 dpi'
    Set-ItemProperty -Path . -Name LogPixels -Value 120
    Set-ItemProperty -Path . -Name Win8DpiScaling 0
 } else {
    write-host 'that didnt work'
 }

# Set-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontDPI\LogPixels'

# Get-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontDPI' | Select-Object -ExpandProperty Property
