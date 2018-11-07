$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

$shareDir = "c:\workspace"

New-Item -Type Directory -Path "c:\" -Name "workspace" -Force
Remove-SmbShare -Name workspace -ErrorAction SilentlyContinue
New-SmbShare -Name workspace -path $shareDir -FullAccess "Users"
