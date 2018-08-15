$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

$installDir = "c:\var\vcap\data\VSBuildTools\2017"
cmd.exe /s /c "c:\var\vcap\packages\vs_buildtools\vs_buildtools.exe --installPath $installDir --passive --wait --norestart --nocache --add Microsoft.VisualStudio.Component.VC.CoreBuildTools --add Microsoft.VisualStudio.Component.VC.Redist.14.Latest --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows10SDK --add Microsoft.VisualStudio.Component.Windows10SDK.17134"

if ($LASTEXITCODE -ne 0) {
	echo "VS Build Tools install failed: $LASTEXITCODE"
}
exit $LASTEXITCODE
