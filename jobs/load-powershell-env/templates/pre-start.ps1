$ErrorActionPreference = "Stop";
trap { $host.SetShouldExit(1) }

$profileScript=@'
$ProgressPreference="SilentlyContinue"
$hklm_env="HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"

function ResetEnv {
  $env:PATH=(Get-ItemProperty -Path "$hklm_env" -Name PATH).PATH
  $env:BAZEL_VC=(Get-ItemProperty -Path "$hklm_env" -Name BAZEL_VC).BAZEL_VC
  $env:BAZEL_SH=(Get-ItemProperty -Path "$hklm_env" -Name BAZEL_SH).BAZEL_SH
  $env:ENVOY_BAZEL_ROOT=(Get-ItemProperty -Path "$hklm_env" -Name ENVOY_BAZEL_ROOT).ENVOY_BAZEL_ROOT
}

ResetEnv
'@

$profilePath="$ENV:WINDIR\system32\WindowsPowerShell\v1.0\profile.ps1"

Set-Content -Value $profileScript -Path $profilePath -Encoding 'UTF8'
