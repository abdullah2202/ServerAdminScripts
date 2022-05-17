# Author: Mohammad Abdullah
# Date: 17/05/2022
# Description: Checks is a user has an AD account from a list of records in a csv.

Import-Module activedirectory

$filename = "users_check.csv"

$records = @(Get-Content $filename).Length
$records--

$Users = Import-csv $filename

$exists = 0
$doesnotexist = 0
$count = 0

$log_filename_ts = (Get-Date).toString("yyyyMMdd_HHmmss")

$Logfile = -join("check_users_log_",$log_filename_ts,".log")

function WriteLog{
    Param ([string]$LogString)
    $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
    $LogMessage = "$Stamp $LogString"
    Add-content $LogFile -value $LogMessage
}


foreach ($User in $Users) {

   $count++

   $pc = ($count/$records) * 100
   $pc = [Math]::Round($pc, 0)

   $Username = $User.SamAccountName

   Write-Progress -Activity "Checking User: $Username" -Status "$pc% Complete" -PercentComplete $pc 

    # If user already exists, change password to the one in the csv
    if (Get-ADUser -F {SamAccountName -eq $Username}) {


        Write-Host "User $Username exists." -ForegroundColor DarkYellow
        WriteLog "$Username exists"
        $exists++
    }
    else {


         Write-Host "User $Username does not exist." -ForegroundColor Cyan
         WriteLog "$Username does not exist"
         $doesnotexist++
    }
   # Start-Sleep -Milliseconds 50
}

Write-Host "Exisiting accounts: $exists"
Write-Host "Non Exisiting accounts: $doesnotexist"
Write-Host "Total Accounts: $records"

Add-content $LogFile -value ""
Add-content $LogFile -value "+ + + + + + + + + +"
Add-content $LogFile -value "+     Results     +"
Add-content $LogFile -value "+ + + + + + + + + +"
Add-content $LogFile -value ""
Add-content $LogFile -value "   Users with Accounts:  $exists"
Add-content $LogFile -value "Users without Accounts:  $doesnotexist"
Add-content $LogFile -value "        Total Accounts:  $records"

