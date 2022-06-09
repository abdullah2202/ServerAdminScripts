# Author: Mohammad Abdullah
# Date: 09/06/2022
# Description: Opens a PowerPoint and starts slideshow automatically
# 

# Link to Powerpoint file
$pptx = "\\servershare\folder\filename.pptx"

function pptloop{
    $running = get-process POWERPNT
    $killed = $false
    if(Test-Path $pptx){
          kill -name POWERPNT          
          Start-Sleep -s 3
          $killed = $true
    }
    if(!$running -or $killed){
          $ppapp = New-Object -ComObject powerpoint.application
          $pres = $ppapp.Presentations.open($pptx)
          $ppapp.visible = "msoTrue"
          $pres.SlideShowSettings.Run()                         
    }
}

#Run loop
pptloop;
