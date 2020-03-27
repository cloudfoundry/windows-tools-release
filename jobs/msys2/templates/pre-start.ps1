$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

$mtx = New-Object System.Threading.Mutex($false, "PathMutex")

if (!$mtx.WaitOne(300000)) {
  throw "Could not acquire PATH mutex"
}

$OldPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path
$msys2UsrBin="c:\var\vcap\packages\msys2\usr\bin"

if (-not $OldPath.Contains($msys2UsrBin)) {
  # add msys2 to the end of the path so binaries like link.exe are found sooner (we likely don't want the one from msys2)
  $NewPath=$OldPath+';'+$msys2UsrBin
  Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
}

$mtx.ReleaseMutex()

# link the msys2 tmp directory to a system wide tmp so generated "/tmp" paths work correctly
mkdir -force C:\tmp
cmd.exe /c mklink C:\var\vcap\packages\msys2\tmp C:\tmp
