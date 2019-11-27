$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

$installDir = "c:\var\vcap\data\VSBuildTools\2019"
$vsConfig = $PSScriptRoot + "\vsconfig"
cmd.exe /s /c "c:\var\vcap\packages\vs_buildtools\vs_buildtools.exe --installPath $installDir --passive --wait --norestart --nocache --config $vsConfig"

if ($LASTEXITCODE -ne 0) {
	echo "VS Build Tools install failed: $LASTEXITCODE"
}
exit $LASTEXITCODE
