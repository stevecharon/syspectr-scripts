Start-Transcript -Path "$env:temp\Install-Teams-Soft-$PID.log" -IncludeInvocationHeader -Append
[int]$exit=$null
$result=@()
$choco=C:\Windows\system32\where.exe choco|select-object -first 1
$InstallDir='C:\ProgramData\chocolatey'
Set-Alias -Name choco -Value "$choco"
$options="upgrade -y --use-system-powershell --no-progress "
$pkg="microsoft-teams.install"
if ($choco){
   foreach ($app in $pkg){$logname="--log-file=$InstallDir\logs\choco-$PID-install-$app.log"
    $myoptions="upgrade $app -y --use-system-powershell --no-progress $logname"
    try{
        $env:ChocolateyInstall="$InstallDir"
        cd $env:ChocolateyInstall
        if ((get-process -Name choco -ea silentlycontinue).count -gt 0 ){Write-Host "." -nonewline}else{
            Start-Process $choco -ArgumentList $myoptions  -Wait -PassThru -NoNewWindow
	    #$options $app 7zip.install pdfcreator notepadplusplus.install adobereader shutup10
	    }
    }
    catch{
        $errortext=$error[0].tostring()
        Write-Warning "[PROBLEM] Error occurred when Installing Software with Chocolatey. Details: $errortext"
        $exit=2
    }
   }
}else{
    Write-Warning "[PROBLEM] Chcocolatey not found"
    $exit=2
}
if ($exit -lt 1){
Write-Host "[GOOD] Installation complete"
$exit=0
}
Stop-Transcript
exit $exit
