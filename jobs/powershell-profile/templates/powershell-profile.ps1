# set PATH to all HKLM Environment
$env:HKLM_ENV="HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
$env:PATH=(Get-ItemProperty -Path "$env:HKLM_ENV" -Name PATH).Path


$env:GOPATH="C:\var\vcap\data\golang-1.21-windows\go"
$env:GOBIN="C:\var\vcap\data\golang-1.21-windows\go\bin"
$env:PATH+=";$env:GOBIN"
