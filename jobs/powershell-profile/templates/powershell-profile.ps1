# set PATH to all HKLM Environment
$env:HKLM_ENV="HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
$env:PATH=(Get-ItemProperty -Path "$env:HKLM_ENV" -Name PATH).Path

If (Test-Path "C:\var\vcap\data\golang-windows") {
  $env:GOPATH="C:\var\vcap\data\golang-windows\go"
  $env:GOBIN="C:\var\vcap\data\golang-windows\go\bin"
  $env:PATH+=";$env:GOBIN"
}

If (Test-Path "C:\var\vcap\data\golang-1.13-windows") {
  $env:GOPATH="C:\var\vcap\data\golang-1.13-windows\go"
  $env:GOBIN="C:\var\vcap\data\golang-1.13-windows\go\bin"
  $env:PATH+=";$env:GOBIN"
}