$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

c:\var\vcap\packages\vc_redist\VC_redist.x64.exe /install /passive /norestart
