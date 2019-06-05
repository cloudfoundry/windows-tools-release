$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

$OldPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path
$AddedFolder="C:\var\vcap\packages\vim\vim_unzipped\vim\vim81"

if (-not $OldPath.Contains($AddedFolder)) {
  $NewPath=$OldPath+';'+$AddedFolder
  Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
}

$func=@'
function vim() {
  if ( -Not (Test-Path ~/_vimrc -PathType Leaf)) {
    cp C:/var/vcap/jobs/vim/bin/_vimrc ~/_vimrc
  }
  vim.exe $args
}
'@

$PsProfile = "$PsHome/Profile.ps1"
if (!(Test-Path $PsProfile))
{

   New-Item -Path $PsProfile -ItemType File -Force
}
Add-Content -Path $PsProfile -Value $func
