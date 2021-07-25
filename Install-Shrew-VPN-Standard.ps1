Start-Transcript -Path "$env:temp\Install-Shrew.log"
try{
    if (!(test-path $env:programdata\Downloads)){ New-Item -ItemType Directory -Path $env:ProgramData -Name Downloads}
    iwr -uri "https://www.shrew.net/download/vpn/vpn-client-2.2.2-release.exe" -OutFile "$env:programdata\Downloads\vpn-client-2.2.2-release.exe"
}
catch{
    $errortext=$error[0].tostring()
    Write-Warning "[PROBLEM] Downloading of ShrewVPN failed. Details: $errortext"
    $exit=2
}
try{
    iex "$env:programdata\Downloads\vpn-client-2.2.2-release.exe /S /STANDARD" 
}
catch{
    $errortext=$error[0].tostring()
    Write-Warning "[PROBLEM] Installing\Upgradeing ShrewVPN Standard failed. Details: $errortext"
    $exit=3
}
if ($exit){ 
    Write-Host "[GOOD} ShrewVPN Standard was installed"
    $exit=0 
}
Stop-Transcript
exit $exit
