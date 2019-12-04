$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

Write-Host "Installing pester"

$pesterModulePath="$env:PROGRAMFILES\WindowsPowerShell\Modules\Pester"

Remove-Item -Recurse -Force "$pesterModulePath"
Copy-Item -Recurse "C:\var\vcap\packages\pester\Pester" "$pesterModulePath"
Write-Host "Installed pester powershell module"

Import-Module Pester -Force
