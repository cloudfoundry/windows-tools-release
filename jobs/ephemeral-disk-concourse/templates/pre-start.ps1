$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

$dockerTmp="C:\ProgramData\docker\tmp"
If ((Test-Path -Path $dockerTmp) -And ((Get-Item $dockerTmp).LinkType -Ne "SymbolicLink")) {
    rmdir $dockerTmp
}
mkdir C:\var\vcap\data\tmp\docker -ea 0
cmd /c mklink /d $dockerTmp C:\var\vcap\data\tmp\docker

# Create Groot Image Store directory
mkdir C:\var\vcap\data\tmp\groot -ea 0


