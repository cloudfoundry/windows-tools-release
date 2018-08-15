$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

$INSTALL_DIR="C:\var\vcap\jobs\ruby\installed"
Start-Process -FilePath "C:\var\vcap\packages\ruby\ruby.exe" `
  -ArgumentList "/verysilent /dir=$INSTALL_DIR /tasks='assocfiles,modpath' " `
  -Wait -PassThru

$mtx = New-Object System.Threading.Mutex($false, "PathMutex")

if (!$mtx.WaitOne(300000)) {
  throw "Could not acquire PATH mutex"
}

$OldPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path
$AddedFolder="$INSTALL_DIR\bin"

if (-not $OldPath.Contains($AddedFolder)) {
  $NewPath=$OldPath+';'+ $AddedFolder
  Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
}

$mtx.ReleaseMutex()
