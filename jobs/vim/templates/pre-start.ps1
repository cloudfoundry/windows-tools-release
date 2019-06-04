$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

$OldPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path
$AddedFolder="C:\var\vcap\packages\vim\vim_unzipped\vim\vim81"

if (-not $OldPath.Contains($AddedFolder)) {
  $NewPath=$OldPath+';'+$AddedFolder
  Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
}

cp bin/_vimrc $env:HOME/_vimrc
