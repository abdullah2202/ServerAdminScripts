# Author: Mohammad Abdullah
# Date: 26/02/2025
# Description: Deletes files modified before a certain date

# Set the path to the folder you want to search
$FolderPath = "C:\Your\Folder\Path"

# Set the number of days to go back
# $DaysOld = 30

# Calculate the cutoff date
# $CutoffDate = (Get-Date).AddDays(-$DaysOld)

# Manually enter the date
$CutoffDate = Get-Date "2022-04-01"



# Get all files in the folder and its subfolders
Get-ChildItem -Path $FolderPath -Recurse -File |

   # Use this line with $DaysOld
   #  Where-Object { $_.LastWriteTime -lt $CutoffDate } |

   # Use this line with $CutOffDate
   Where-Object { $_.LastWriteTime -lt $CutoffDate } |


   # Removes the file - Test first and then uncomment this line to remove
   #  Remove-Item -Force

   # Test and print which files will be removed
   Write-Host $_.FullName
