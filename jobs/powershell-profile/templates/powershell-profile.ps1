# set PATH to all HKLM Environment
$env:HKLM_ENV="HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
$env:PATH=(Get-ItemProperty -Path "$env:HKLM_ENV" -Name PATH).Path

