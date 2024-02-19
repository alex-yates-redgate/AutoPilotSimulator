# Config required for rgclone.exe
[Environment]::SetEnvironmentVariable('RGCLONE_ACCESS_TOKEN', $RGCLONE_ACCESS_TOKEN)
[Environment]::SetEnvironmentVariable('RGCLONE_API_ENDPOINT', $RGCLONE_API_ENDPOINT)

$containerName = "Widget-" + $OctopusParameters["Octopus.Environment.Name"]
# redirect output to stdout to avoid errors/warnings
echo "##octopus[stderr-progress]"
~/redgate/rgclone delete dc "$containerName-previous" # If there is already a 'previous' container, delete it
~/redgate/rgclone update dc $containerName -n "$containerName-previous" -t 10m # Rename current container to previous and set 10m lifetime
# undoing the stdout hack above
echo "##octopus[stderr-default]"

# Create the database environment, and save the JDBC connection string
$dcInfo = (~/redgate/rgclone create dc -i Widget --name "$containerName" -t 3h -o json) | ConvertFrom-Json
$jdbc = $dcInfo.jdbcConnectionString
$jdbcWithDbName = $jdbc + "DatabaseName=WidgetProduction"

# Set the JDBC connection string as a sensitive variable
Set-OctopusVariable -Name jdbcConnectionString -Value "$jdbcWithDbName" -Sensitive