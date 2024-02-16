export RGCLONE_API_ENDPOINT=$(get_octopusvariable "RGCLONE_API_ENDPOINT")
export RGCLONE_ACCESS_TOKEN=$(get_octopusvariable "RGCLONE_ACCESS_TOKEN")
RGCLONE_DOWNLOAD_URL="$RGCLONE_API_ENDPOINT"
RGCLONE_DOWNLOAD_URL+="cloning-api/download/cli/linux-amd64"
echo "Downloading and unzipping rgclone from $RGCLONE_DOWNLOAD_URL"

# redirect output to stdout to avoid errors/warnings
echo "##octopus[stderr-progress]"
curl $RGCLONE_DOWNLOAD_URL | tar xz
# undoing the stdout hack above
echo "##octopus[stderr-default]"

mkdir ~/redgate -p # cretes a redgate dir (if not exists)
mv ./rgclone ~/redgate/rgclone -f # copies rgclone to persistent dir, and overwrites existing file

echo "rgclone version is:"
~/redgate/rgclone version

echo "Installing flyway"
wget -qO- https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/8.5.13/flyway-commandline-8.5.13-linux-x64.tar.gz | tar xvz #&& sudo ln -s `pwd`/flyway-8.5.13/flyway /usr/local/bin 

echo "Listing files in current dir"
ls -la

echo "Listing files in flyway dir"
ls -la flyway-8.5.13

echo "Listing files in redgate dir"
ls -la ~/redgate

echo "Listing files in redgate/rgclone dir"
ls -la ~/redgate/rgclone

echo "Listing files in redgate/flyway dir"
ls -la ~/redgate/flyway

echo "Copying flyway to persistent dir"
mv "./flyway-8.5.13/flyway.cmd" ~/redgate -f # copies rgclone to persistent dir, and overwrites existing file

echo "Trying flyway version"
./redgate/flyway version