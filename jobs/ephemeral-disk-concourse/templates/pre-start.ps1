$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

if (test-path -Path C:\ProgramData\docker\tmp) {
    rmdir C:\ProgramData\docker\tmp
}
mkdir C:\var\vcap\data\tmp\docker
cmd /c mklink /d C:\ProgramData\docker\tmp C:\var\vcap\data\tmp\docker

