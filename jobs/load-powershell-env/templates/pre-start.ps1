$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

$profileScript=@'
$ProgressPreference="SilentlyContinue"
$hklm_env="HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"

function ResetEnv {
  $env:PATH=(Get-ItemProperty -Path "$hklm_env" -Name PATH).Path
}

ResetEnv
'@

$profilePath="$ENV:WINDIR\system32\WindowsPowerShell\v1.0\profile.ps1"

Set-Content -Value $profileScript -Path $profilePath -Encoding 'UTF8'
