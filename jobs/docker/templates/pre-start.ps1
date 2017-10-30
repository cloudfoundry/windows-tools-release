$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

$env:path += ";C:\var\vcap\packages\docker\docker\"
$existingMachinePath = [Environment]::GetEnvironmentVariable("Path",[System.EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("Path", $existingMachinePath + ";C:\var\vcap\packages\docker\docker", [EnvironmentVariableTarget]::Machine)

dockerd --register-service
Start-Service Docker

