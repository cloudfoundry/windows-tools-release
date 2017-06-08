$INSTALL_DIR="C:\var\vcap\jobs\ruby\installed"
Start-Process -FilePath "C:\var\vcap\packages\ruby\ruby.exe" `
  -ArgumentList "/verysilent /dir=$INSTALL_DIR /tasks='assocfiles,modpath' " `
  -Wait -PassThru

$OldPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path
$NewPath=$OldPath+';'+ "$INSTALL_DIR\bin"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
