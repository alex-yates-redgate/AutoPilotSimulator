# Config required for rgclone.exe
[Environment]::SetEnvironmentVariable('RGCLONE_ACCESS_TOKEN', $RGCLONE_ACCESS_TOKEN)
[Environment]::SetEnvironmentVariable('RGCLONE_API_ENDPOINT', $RGCLONE_API_ENDPOINT)

# Create the database environment, and save the JDBC connection string
$dcInfo = (~/redgate/rgclone create dc -i Widget -o json) | ConvertFrom-Json
$jdbc = $dcInfo.jdbcConnectionString

Set-OctopusVariable -Name jdbcConnectionString -Value "$jdbc" -Sensitive