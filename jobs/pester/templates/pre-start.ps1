$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

Write-Log "Installing Pester"
$powershellModulePath="$env:PROGRAMFILES\WindowsPowerShell\Modules"
$pesterModulePath="$powershellModulePath\Pester"

if (Test-Path $pesterModulePath) {
    Write-Log "Removing existing default Pester module so it can be upgraded"
    takeown /F $pesterModulePath /A /R
    icacls $pesterModulePath /reset
    icacls $pesterModulePath /grant Administrators:'F' /inheritance:d /T
    Remove-Item -Recurse -ErrorAction Ignore "$pesterModulePath" -Confirm:$false
}
Copy-Item -Recurse "C:\var\vcap\packages\pester\Pester" "$powershellModulePath\" -Verbose
Import-Module Pester -Force
Write-Log "Pester Installed"
