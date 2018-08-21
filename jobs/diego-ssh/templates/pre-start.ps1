$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

$mtx = New-Object System.Threading.Mutex($false, "PathMutex")

if (!$mtx.WaitOne(300000)) {
  throw "Could not acquire PATH mutex"
}

$ssh_home="C:\"
$env:HKLM_ENV="HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
$env:SERVICE_WRAPPER_URL="https://github.com/kohsuke/winsw/releases/download/winsw-v2.1.2/WinSW.NET4.exe"

$ErrorActionPreference = "SilentlyContinue";
Stop-Service sshd
(Get-WmiObject Win32_Service -filter "name='sshd'").Delete()
$ErrorActionPreference = "Stop";

Invoke-WebRequest -Uri https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub -OutFile "$ssh_home\authorized_key" -UseBasicParsing
$env:SSH_AUTHORIZEDKEY="$(cat $ssh_home\authorized_key)"
Set-ItemProperty -Path "$env:HKLM_ENV" -Name SSH_AUTHORIZEDKEY -Value $env:SSH_AUTHORIZEDKEY

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri $env:SERVICE_WRAPPER_URL -OutFile "$ssh_home\service-wrapper.exe" -UseBasicParsing
$XML=@"
<service>
  <id>sshd</id>
  <name>sshd</name>
  <description>Start sshd</description>
  <executable>c:\var\vcap\packages\diego-ssh\diego-ssh.exe</executable>
  <arguments>-authorizedKey="%SSH_AUTHORIZEDKEY%" -address="0.0.0.0:22" -inheritDaemonEnv=true</arguments>
  <logmode>rotate</logmode>
</service>
"@
Set-Content -Value $XML -Path "$ssh_home\\service-wrapper.xml" -Encoding 'UTF8'
Start-Process -FilePath "$ssh_home\\service-wrapper.exe" -ArgumentList "install" -Wait -NoNewWindow -PassThru

netsh advfirewall firewall add rule name="SSHD" dir=in action=allow service=sshd enable=yes
if ($LASTEXITCODE -ne 0) {
  exit $LASTEXITCODE
}
netsh advfirewall firewall add rule name="SSHD" dir=in action=allow program="C:\var\vcap\packages\diego-ssh\diego-ssh.exe" enable=yes
if ($LASTEXITCODE -ne 0) {
  exit $LASTEXITCODE
}
netsh advfirewall firewall add rule name="ssh" dir=in action=allow protocol=TCP localport=22
if ($LASTEXITCODE -ne 0) {
  exit $LASTEXITCODE
}


"Setting 'sshd' service start type to automatic"
Set-Service -Name sshd -StartupType Automatic

"Starting 'sshd' service"
Start-Service -Name sshd

$mtx.ReleaseMutex()
