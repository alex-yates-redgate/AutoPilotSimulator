# Config required for octo.exe
octopus config set url $OctopusParameters["Octopus.Web.ServerUri"]
octopus config set apikey $OctopusParameters["OCTOPUS_API_KEY"]

# Create the database environment, and save the JDBC connection string
$jdbc = $OctopusParameters["Octopus.Action[Create rgclone data container].Output.jdbcConnectionString"]

# Get the variableID from the API
Write-Host "Getting variable ID from the Octopus API"

$variableName = "DB_CONNECTION_STRING"
$octopusUrl = $OctopusParameters["Octopus.Web.ServerUri"]
$octopusApiKey= $OctopusParameters["OCTOPUS_API_KEY"]
$header = @{ "X-Octopus-ApiKey" = $octopusAPIKey }

$spaceId = $OctopusParameters["Octopus.Space.Id"]
$projectId = $OctopusParameters["Octopus.Project.Id"]
$environmentId = $OctopusParameters["Octopus.Environment.Id"]

$sensitiveVariableset = Invoke-RestMethod -Method Get -Uri "$octopusURL/api/$($spaceId)/projects/$($projectId)/variables" -Headers $header

$matchingVariables = @($sensitiveVariableset.Variables | Where-Object {$_.Name -ieq $variableName -and $_.Scope.Environment -icontains $environmentId})
if($matchingVariables.Count -ne 1) {
    throw "Couldnt find a variable named: '$variableName' with matching environment scope ($environmentId)"
}
else {
    $matchingVariable = $matchingVariables | Select-Object -First 1
    Write-Host "Variable Id: $($matchingVariable.Id)"
}

Write-Host "Updating the variable value"
octopus project variables update --project $OctopusParameters["Octopus.Project.Name"] --space $OctopusParameters["Octopus.Space.Name"] --name "DB_CONNECTION_STRING" --value "$jdbc" --environment-scope $OctopusParameters["Octopus.Environment.Name"] --id $matchingVariable.Id --no-prompt
