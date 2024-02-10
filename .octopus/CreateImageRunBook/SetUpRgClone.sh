RGCLONE_API_ENDPOINT=$(get_octopusvariable "RGCLONE_API_ENDPOINT")
RGCLONE_ACCESS_TOKEN=$(get_octopusvariable "RGCLONE_ACCESS_TOKEN")
RGCLONE_DOWNLOAD_URL="$RGCLONE_API_ENDPOINT"
RGCLONE_DOWNLOAD_URL+="cloning-api/download/cli/linux-amd64"
echo "RGCLONE_API_ENDPOINT is: $RGCLONE_API_ENDPOINT"
echo "RGCLONE_DOWNLOAD_URL is: $RGCLONE_DOWNLOAD_URL"
echo "Downloading and unzipping rgclone from $RGCLONE_DOWNLOAD_URL"
curl $RGCLONE_DOWNLOAD_URL | tar xz
echo "Running ls to see if rgclone is there"
ls
echo "Exporting RGCLONE_API_ENDPOINT"
export RGCLONE_API_ENDPOINT=RGCLONE_API_ENDPOINT
echo "Attempting to use rgclone"
./rgclone version
./rgclone get all