# Author: Mohammad Abdullah
# Date: 17/05/2022
# Description: Creates new users in AD, if they already exist, change their password to the one in the csv.

Import-Module activedirectory

$Users = Import-csv "users.csv"

$Groups = "Students","KS1","DomainUsers"


$total_new = 0
$total_changed = 0

foreach ($User in $Users) {

   $Username = $User.SamAccountName
   $Password = ConvertTo-SecureString $User.password -AsPlainText -Force  

    # If user already exists, change password to the one in the csv
    if (Get-ADUser -F {SamAccountName -eq $Username}) {
        
        Set-ADAccountPassword -Identity $Username -NewPassword $Password -Reset

        Write-Host "Password changed for $Username" -ForegroundColor DarkYellow
        
        $total_changed++
    }
    else {
        # New User

        $userProps = @{
            SamAccountName             = $User.SamAccountName                   
            Path                       = $User.path      
            GivenName                  = $User.GivenName 
            Surname                    = $User.Surname
            Name                       = $User.Name
            DisplayName                = $User.DisplayName
            UserPrincipalName          = $user.UserPrincipalName
            Description                = $User.Description
            AccountPassword            = (ConvertTo-SecureString $User.password -AsPlainText -Force) 
            Enabled                    = $true
            ChangePasswordAtLogon      = $false
            CannotChangePassword       = $true
            HomeDrive                  = "H:"
            HomeDirectory              = "\\CSVR\Users\$Username"
            PasswordNeverExpires       = $true
        }  

         New-ADUser @userProps

         #Add to groups
         foreach($Group in $Groups){
            Add-ADGroupMember -Identity $Group -Members $Username
         }
         
         Write-Host "The user account $Username is created." -ForegroundColor Cyan
   
         $total_new++
    }

}

Write-Host "Total new accounts: $total_new"
Write-Host "Total changed accounts: $total_changed"
