RGCLONE_API_ENDPOINT=$(get_octopusvariable "RGCLONE_API_ENDPOINT")
RGCLONE_ACCESS_TOKEN=$(get_octopusvariable "RGCLONE_ACCESS_TOKEN")

echo "RGCLONE_API_ENDPOINT is: $RGCLONE_API_ENDPOINT"

echo "Downloading rgclone"

curl $RGCLONE_API_ENDPOINT/cloning-api/download/cli/linux-amd64 

echo "Running ls"

ls

echo "Unzipping rgclone"
tar xz rgclone.tar.gz

echo "Running ls"

ls

echo "Attempting to use rgclone"

./rgclone version

./rgclone get all