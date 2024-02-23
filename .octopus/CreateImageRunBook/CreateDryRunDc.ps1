# Config required for rgclone.exe
[Environment]::SetEnvironmentVariable('RGCLONE_ACCESS_TOKEN', $RGCLONE_ACCESS_TOKEN)
[Environment]::SetEnvironmentVariable('RGCLONE_API_ENDPOINT', $RGCLONE_API_ENDPOINT)

$containerName = "Widget-" + $OctopusParameters["Octopus.Environment.Name"] + "-dryrun-" + $OctopusParameters["Octopus.Deployment.Id"]

# Create the database environment, and save the JDBC connection string
$dcInfo = (~/redgate/rgclone create dc -i Widget_Octopus --name "$containerName" -t 15m -o json) | ConvertFrom-Json
$jdbc = $dcInfo.jdbcConnectionString
$jdbcWithDbName = $jdbc + "DatabaseName=WidgetProduction"

# Set the JDBC connection string as a sensitive variable
Set-OctopusVariable -Name jdbcConnectionString -Value "$jdbcWithDbName" -Sensitive