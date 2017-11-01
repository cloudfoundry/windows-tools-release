$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

$mtx = New-Object System.Threading.Mutex($false, "PathMutex")

if (!$mtx.WaitOne(5000)) {
  throw "Could not acquire PATH mutex"
}

$env:path += ";C:\var\vcap\packages\docker\docker\"
$existingMachinePath = [Environment]::GetEnvironmentVariable("Path",[System.EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("Path", $existingMachinePath + ";C:\var\vcap\packages\docker\docker", [EnvironmentVariableTarget]::Machine)

$mtx.ReleaseMutex()

dockerd --register-service
Start-Service Docker

