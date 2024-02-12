# Config required for octo.exe
octopus config set url $OctopusParameters["Octopus.Web.ServerUri"]
octopus config set apikey $OctopusParameters["OCTOPUS_API_KEY"]

# Create the database environment, and save the JDBC connection string
$jdbc = $OctopusParameters["Octopus.Action[Create environment].Output.jdbcConnnectionString"]
octopus project variables update --project $OctopusParameters["Octopus.Project.Name"] --name "DB_CONNECTION_STRING" --value "$jdbc" --environment-scope $OctopusParameters["Octopus.Environment.Name"] --no-prompt
