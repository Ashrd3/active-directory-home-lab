# ============================================================
# Bulk User Creation Script
# Author: Ash
# Lab: ashlab.local Active Directory Home Lab
# Description: Imports users from a CSV file and creates
#              AD accounts in their respective OUs
# ============================================================

Import-Module ActiveDirectory

$csvPath = "C:\users.csv"
$defaultPassword = ConvertTo-SecureString "Welcome1!" -AsPlainText -Force
$domain = "ashlab.local"

# Import users from CSV
$users = Import-Csv $csvPath

foreach ($user in $users) {

    $ouPath  = "OU=$($user.OU),DC=ashlab,DC=local"
    $fullName = "$($user.FirstName) $($user.LastName)"

    try {
        New-ADUser `
            -Name $fullName `
            -GivenName $user.FirstName `
            -Surname $user.LastName `
            -SamAccountName $user.Username `
            -UserPrincipalName "$($user.Username)@$domain" `
            -Path $ouPath `
            -Department $user.Department `
            -AccountPassword $defaultPassword `
            -Enabled $true `
            -PasswordNeverExpires $false `
            -ChangePasswordAtLogon $true

        Write-Host "Created user: $fullName" -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to create $fullName : $_" -ForegroundColor Red
    }
}

Write-Host "`nAll done! Open ADUC to verify users." -ForegroundColor Cyan
