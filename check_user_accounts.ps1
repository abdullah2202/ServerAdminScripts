# Author: Mohammad Abdullah
# Date: 17/05/2022
# Description: Checks is a user has an AD account from a list of records in a csv.

Import-Module activedirectory

$filename = "users_check.csv"

$records = @(Get-Content $filename).Length

$Users = Import-csv $filename

$exists = 0
$doesnotexist = 0
$count = 0


foreach ($User in $Users) {

   $count++

   $pc = ($count/$records) * 100
   $pc = [Math]::Round($pc, 0)

   $Username = $User.SamAccountName

   Write-Progress -Activity "Checking User: $Username" -Status "$pc% Complete" -PercentComplete $pc 

    # If user already exists, change password to the one in the csv
    if (Get-ADUser -F {SamAccountName -eq $Username}) {


        Write-Host "User $Username exists." -ForegroundColor DarkYellow
        $exists++
    }
    else {


         Write-Host "User $Username does not exist." -ForegroundColor Cyan
         $doesnotexist++
    }

}

Write-Host "Exisiting accounts: $exists"
Write-Host "Non Exisiting accounts: $doesnotexist"
Write-Host "Total Accounts: $records"
