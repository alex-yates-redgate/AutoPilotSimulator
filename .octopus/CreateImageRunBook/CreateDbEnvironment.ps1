Set-Location ~/redgate
$dcInfo = (rgclone create dc -i Widget -o json) | ConvertFrom-Json

$jdbc = $dcInfo.jdbcConnectionString

Write-Output "JDBC = $jdbc"