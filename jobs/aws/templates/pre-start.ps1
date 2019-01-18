$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

$mtx = New-Object System.Threading.Mutex($false, "PathMutex")

if (!$mtx.WaitOne(300000)) {
  throw "Could not acquire PATH mutex"
}

$logDir = "c:\var\vcap\sys\log\aws"
$path=(Get-ChildItem "c:\var\vcap\packages\aws\AWSCLI64*.msi").FullName

Start-Process -FilePath msiexec -ArgumentList "/i $path /qn /lxv $logDir\install.log" -Wait -PassThru -NoNewWindow

$mtx.ReleaseMutex()
