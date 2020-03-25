$ErrorActionPreference = "Stop";

echo "Querying mysql service" | Out-File -Encoding ASCII -Append "c:\var\vcap\sys\log\mysql\drain.log"
$mysql=(Get-Service | where { $_.Name -eq 'mysql' })
if ($mysql -eq $null) {
    echo "mysql service not found; Exiting 0" | Out-File -Encoding ASCII -Append "c:\var\vcap\sys\log\mysql\drain.log"
    "0"
    Exit 0
}

echo "mysql service found" | Out-File -Encoding ASCII -Append "c:\var\vcap\sys\log\mysql\drain.log"
If ($mysql.Status -Eq "Running") {
    echo "mysql service running; Stopping" | Out-File -Encoding ASCII -Append "c:\var\vcap\sys\log\mysql\drain.log"
    Stop-Service $mysql |  Out-File -Encoding ASCII -Append "c:\var\vcap\sys\log\mysql\drain.log"
}
echo "mysql service drained; Exit 0" | Out-File -Encoding ASCII -Append "c:\var\vcap\sys\log\mysql\drain.log"

"0"
Exit 0
