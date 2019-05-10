$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

$shareDir = "e:\workspace"

Get-Disk | Where-Object PartitionStyle -eq 'RAW' | Initialize-Disk -PartitionStyle MBR -PassThru | New-Partition -AssignDriveLetter -UseMaximumSize
Format-Volume -DriveLetter E -FileSystem NTFS -Confirm:$false

New-Item -Type Directory -Path "e:\" -Name "workspace" -Force

Remove-SmbShare -Name "workspace" -ErrorAction SilentlyContinue -Force
New-SmbShare -Name "workspace" -path $shareDir -FullAccess "Users"
