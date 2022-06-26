# Description: Used to rename computer using asset number input from user

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted

#param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if((Test-Admin) -eq $false){
    if($elevated){
        # tried to elevate, did not work, aborting
    }else{
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

$bios = (gwmi win32_bios).SerialNumber
$serial = $bios.substring($bios.length - 4, 4)
$serial = $serial.toUpper()
$newname = ""
$cred = get-credential

# Input Computer name
$userSerial = Read-Host -Prompt "PC Name will be DT-{ASSET} Enter Asset Number."

if($userSerial.length -gt 0){
    $newname = "DT-$userSerial"
} else {
    $newname = "DT-$serial"
}

Write-Host "New PC name will be: $newname"

Rename-Computer -newName "$newname" -domainCredential $cred -Force -Restart

#Write-Host "$newname"

Read-Host -Prompt "Press Enter to exit"
