$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

$mtx = New-Object System.Threading.Mutex($false, "PathMutex")

if (!$mtx.WaitOne(300000)) {
  throw "Could not acquire PATH mutex"
}

$installDir = "c:\var\vcap\data\llvm"
Start-Process -FilePath c:\var\vcap\packages\llvm\LLVM-win64.exe -ArgumentList "/S /D=$installDir" -Wait -PassThru -NoNewWindow

$mtx.ReleaseMutex()
