$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

Write-Host 'Set default powershell profile...'
$profileTemplate="c:\var\vcap\jobs\powershell-profile\bin\powershell-profile.ps1"
$profileDest="$env:WINDIR\system32\WindowsPowerShell\v1.0\profile.ps1"

Copy-Item -Path "$profileTemplate" -Destination "$profileDest"  -Force
