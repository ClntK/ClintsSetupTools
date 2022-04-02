# FileName: SetPassword.psm1
# Created Date: 4/2/2022
# Author: Clint Kline
# Purpose: -- A PS Module to automate resetting a users password.


# !!! THIS FILE IS NOT YET FULLY FUNCTIONAL.
# !!! EXECUTE ON VM OR AT YOUR OWN RISK.


#----------------------------
#  ResetPassword
#----------------------------

function ResetPassword {

    # Self-elevate the script if required
    set-executionpolicy -executionpolicy remotesigned -scope process

    $confirmCreate = Read-Host "`n>> Completing this task will reset your password.`n>> Do you wish to continue?"
    Write-Output `n

    if ($confirmCreate.ToUpper() -eq 'Y') {

        if (Get-Credential) {

            $User = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
            $Password = Read-Host -prompt ">> New Password"
            $PWord = ConvertTo-SecureString -String $Password -AsPlainText -Force
            New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
        
            Set-LocalUser -Password $PWord
            $viewPW = Read-Host -prompt  ">> Password has been reset. Would you like to view it? (y to view, any other key to continue)"
            
            if ($viewPW.ToUpper() -eq 'Y') {
                $Password
            }
            else {
                continue
            }
            Write-Output `n 
            Write-Output ">> Success. User - $UserName - Password has been changed."
            
        }
        else {

            Write-Output ">> Incorrect. Try again."
            ResetPassword

        }

    }
    elseif ($confirmCreate -eq 'N') {

        Write-Output "Your password has not been changed.`n"

    }
    else { 
        
        Write-Output "Please confirm or deny the password change." 
        ResetPassword

    }

}
Write-Host "`r`n`r`n"
# make module exportable
Export-ModuleMember -Function ResetPassword