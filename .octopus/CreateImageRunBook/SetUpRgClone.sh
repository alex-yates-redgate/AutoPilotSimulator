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

rm -r ~/redgate -f # removes redgate dir (if exists)
mkdir ~/redgate -p # cretes a redgate dir (if not exists)
mv ./rgclone ~/redgate/rgclone -f # copies rgclone to persistent dir, and overwrites existing file

echo "rgclone version is:"
~/redgate/rgclone version


#echo "Installing Java 17"
#sudo apt install openjdk-17-jdk -y

#echo "Downloading and extracting flyway"
#wget -qO- https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/8.5.13/flyway-commandline-8.5.13-linux-x64.tar.gz | tar xvz

#echo "Copying flyway to persistent dir"
#mv "./flyway-8.5.13/flyway" ~/redgate -f # copies flyway to persistent dir, and overwrites existing file

#echo "Attempting flyway version"
#~/redgate/flyway version # Currently fails because of missing Java dependency