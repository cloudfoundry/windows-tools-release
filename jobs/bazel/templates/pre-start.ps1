$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

$mtx = New-Object System.Threading.Mutex($false, "PathMutex")

if (!$mtx.WaitOne(300000)) {
  throw "Could not acquire PATH mutex"
}

$OldPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path
$AddedFolder="c:\var\vcap\packages\bazel\"

if (-not $OldPath.Contains($AddedFolder)) {
  $NewPath=$OldPath+';'+$AddedFolder
  Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
}

$BazelSh="C:\var\vcap\packages\msys2\usr\bin\bash.exe"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name BAZEL_SH -Value $BazelSh

$BazelVc="C:\var\vcap\data\VSBuildTools\2017\VC"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name BAZEL_VC -Value $BazelVc

$EnvoyBazelRoot="c:\_eb"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name ENVOY_BAZEL_ROOT -Value $EnvoyBazelRoot

Add-Content -Path "C:\Windows\system32\drivers\etc\hosts" -Encoding ASCII "::1 localhost`n127.0.0.1 localhost`n"

$mtx.ReleaseMutex()
