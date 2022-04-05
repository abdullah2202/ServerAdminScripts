cls

# Author: Mohammad Abdullah
# Date: 02/03/2021
# Description: Searches Google File Stream folder for latest update directory and run the program.

$rootFolder = 'C:\Program Files\Google\Drive File Stream\'

$Lnk = (Get-Childitem -Path $rootFolder -Include "GoogleDriveFS.exe" -File -Recurse | % {"$($_.CreationTime), $($_.FullName)"}) | Sort-Object -Descending | Select -First 1 | %{$_.Split(",")[1].Trim()}

& $Lnk
