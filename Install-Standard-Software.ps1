Start-Transcript -Path "$env:temp\Install-Standard-Soft-$PID.log" -IncludeInvocationHeader -Append
[int]$exit=$null
$result=@()
$choco=C:\Windows\system32\where.exe choco|select-object -first 1
Set-Alias -Name choco -Value "$choco"
$options="upgrade -y --use-system-powershell --no-progress "
#change packages to install on the line below
$pkg="7zip.install","notepadplusplus.install","adobereader","shutup10","greenshot"
if ($choco){
   foreach ($app in $pkg){
    $myoptions="upgrade $app -y --use-system-powershell --no-progress --log-file-name=$env:Temp\choco-$PID-install-$app.log"
    try{
        $InstallDir='C:\ProgramData\chocolatey'
        $env:ChocolateyInstall="$InstallDir"
        cd $env:ChocolateyInstall
        if ((get-process -Name choco -ea silentlycontinue).count -gt 0 ){Write-Host "." -nonewline}else{
            $p=Start-Process $choco -ArgumentList $myoptions  -Wait -PassThru -NoNewWindow
	    #$options $app 7zip.install pdfcreator notepadplusplus.install adobereader shutup10
	}
        #if ((get-process -Name choco).count -gt 0){Write-Host "." -nonewline}else{
         #   iex "$choco upgrade -y $options --log-file-name=$env:Temp\choco-$PID-install-greenshot.log greenshot"}
        #if ((get-process -Name choco).count -gt 0){Write-Host "." -nonewline}else{
         #   iex "$choco upgrade -y $options --log-file-name=$env:Temp\choco-$PID-install-teams.log microsoft-teams.install"}
    }
    catch{
        $errortext=$error[0].tostring()
        Write-Warning "[PROBLEM] Error occurred when Installing Software with Chocolatey. Details: $errortext"
        $exit=2
    }
    if ($p -and $p.HasExited){
        $ec=$p.ExitCode
        $et=$p.ExitTime
        $result+="$ec $et $app"}
    }
}else{
    Write-Warning "[PROBLEM] Chcocolatey not found"
    $exit=2
}
Stop-Transcript
if ($exit -lt 1){
Write-Host "[GOOD] Installation complete"
foreach($res in $result){Write-Host "$res"}
exit 0
}else{
    exit $exit
}
