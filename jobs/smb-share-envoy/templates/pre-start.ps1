$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

$shareDir = "e:\workspace"

if (!(test-path E:\workspace)) {
  Clear-Disk -Number 1 -RemoveData -RemoveOEM -Confirm:$false
  Initialize-Disk -Number 1 -PartitionStyle MBR
  New-Partition -DiskNumber 1 -AssignDriveLetter -UseMaximumSize

  Format-Volume -DriveLetter E -FileSystem NTFS -Confirm:$false
  New-Item -Type Directory -Path "e:\" -Name "workspace" -Force
}

Remove-SmbShare -Name "workspace" -ErrorAction SilentlyContinue -Force
New-SmbShare -Name "workspace" -path $shareDir -FullAccess "Users"
