# set PATH to all HKLM Environment
$env:HKLM_ENV="HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
$env:PATH=(Get-ItemProperty -Path "$env:HKLM_ENV" -Name PATH).Path


$GoDataPath=(Get-Item 'C:\var\vcap\data\golang-*-windows\go').FullName
$env:GOPATH=$GoDataPath
$env:GOBIN="$GoDataPath\bin"
$env:PATH+=";$env:GOBIN"
