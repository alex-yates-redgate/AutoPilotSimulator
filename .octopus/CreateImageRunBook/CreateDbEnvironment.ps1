[Environment]::SetEnvironmentVariable('RGCLONE_ACCESS_TOKEN', $RGCLONE_ACCESS_TOKEN)
[Environment]::SetEnvironmentVariable('RGCLONE_API_ENDPOINT', $RGCLONE_API_ENDPOINT)

$dcInfo = (~/redgate/rgclone create dc -i Widget -o json) | ConvertFrom-Json
$jdbc = $dcInfo.jdbcConnectionString
Write-Output "JDBC = $jdbc"
