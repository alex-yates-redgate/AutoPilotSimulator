RGCLONE_API_ENDPOINT=$(get_octopusvariable "RGCLONE_API_ENDPOINT")
RGCLONE_ACCESS_TOKEN=$(get_octopusvariable "RGCLONE_ACCESS_TOKEN")

echo "RGCLONE_API_ENDPOINT is: $RGCLONE_API_ENDPOINT"

curl $RGCLONE_API_ENDPOINT/cloning-api/download/cli/linux-amd64 | tar xz

ls

./rgclone version

./rgclone get all