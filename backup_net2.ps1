# --- Configuration ---
$SourceFolder  = "\\RemotePC01\C$\Net2 Access Control\Backup\Net2"
$DestFolder    = "\\FileServer\BackupShare\Daily"
$LogFile       = "\\FileServer\BackupShare\Logs\TransferLog.txt"
$KeepCount     = 5  # Number of backups to keep at the destination

# Ensure directories exist
if (!(Test-Path $DestFolder)) { New-Item -ItemType Directory -Path $DestFolder -Force | Out-Null }
if (!(Test-Path (Split-Path $LogFile))) { New-Item -ItemType Directory -Path (Split-Path $LogFile) -Force | Out-Null }

$LogTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

try {
    # 1. Identify the latest backup file in the source folder
    $LatestFile = Get-ChildItem -Path $SourceFolder -Filter "*.bak" | 
                  Sort-Object LastWriteTime -Descending | 
                  Select-Object -First 1

    if ($null -ne $LatestFile) {
        $SourcePath = $LatestFile.FullName
        $FileName   = $LatestFile.Name
        
        # 2. Perform Copy to destination
        Copy-Item -Path $SourcePath -Destination "$DestFolder\$FileName" -Force -ErrorAction Stop
        $LogEntry = "[$LogTime] SUCCESS: Copied $FileName"

        # 3. Cleanup Old Backups at the destination
        $OldFiles = Get-ChildItem -Path $DestFolder -Filter "*.bak" | 
                    Sort-Object LastWriteTime | 
                    Select-Object -SkipLast $KeepCount

        foreach ($File in $OldFiles) {
            Remove-Item $File.FullName -Force
            $LogEntry += " | CLEANUP: Deleted old backup $($File.Name)"
        }
    } else {
        $LogEntry = "[$LogTime] FAILED: No .bak files found in $SourceFolder"
    }
} catch {
    $LogEntry = "[$LogTime] ERROR: $($_.Exception.Message)"
}

# --- Logging ---
$LogEntry | Out-File -FilePath $LogFile -Append -Encoding utf8
Write-Output $LogEntry
