$appname="Bitdefender Endpoint Client"
$logname=$appname -replace " ","-"
#Start-Transcript -Path "$env:temp\Install-$logname-$PID.log"
$url="https://mandrillapp.com/track/click/30520728/cloudgz-ecs.gravityzone.bitdefender.com?p=your-personal-link-here--you-grab-it-from-your-gravityzone-management-console"
$exename="setupdownloader_`[keep-this-base64-entry-otherwise-the-downloader-wont-trigger-your-bitdefender-tenant`].exe"
try{
    if (!(test-path $env:programdata\Downloads)){ New-Item -ItemType Directory -Path $env:ProgramData -Name Downloads}
    iwr -uri "$url" -OutFile "C:\Users\Public\Desktop\setupdownloader-$PID.exe"
}
catch{
    $errortext=$error[0].tostring()
    Write-Warning "[PROBLEM] Downloading of $appname failed. Details: $errortext"
    $exit=2
}
#Would rather execute the setupdownloader, but that would not work for me so I decided to just place 
#it on the public desktop to click and run 
if (test-path "C:\Users\Public\Desktop\\setupdownloader-$PID.exe")
    { Get-ChildItem -Filter "setupdownloader-$PID.exe" -Path "C:\Users\Public\Desktop\" |Rename-Item -newname $exename -Force 
    }
if ($exit=$null){ 
    Write-Host "[GOOD} $appname was prepared on Public Desktop"
    $exit=0 
}
#Stop-Transcript
exit $exit
