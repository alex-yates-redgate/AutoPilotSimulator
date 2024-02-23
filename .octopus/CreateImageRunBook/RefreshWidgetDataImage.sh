export RGCLONE_API_ENDPOINT=$(get_octopusvariable "RGCLONE_API_ENDPOINT")
export RGCLONE_ACCESS_TOKEN=$(get_octopusvariable "RGCLONE_ACCESS_TOKEN")

echo "##octopus[stderr-progress]"

echo "Creating new Widget data image"
~/redgate/rgclone create di -f ./Widget.yaml --name Widget_Octopus_New

echo "Deleting previous Widget data image"
~/redgate/rgclone delete di Widget_Octopus_Previous

echo "Renaming current Widget data image to 'Widget_Previous'"
~/redgate/rgclone update di Widget_Octopus --name Widget_Octopus_Previous

echo "Renaming new Widget data image to 'Widget'"
~/redgate/rgclone update di Widget_Octopus_New --name Widget_Octopus

echo "##octopus[stderr-default]"
