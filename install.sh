# Exit immediately if command fails
set -e

if [ -z $NOMAD_PATH ]; then 
	export NOMAD_PATH="$(dirname $(realpath ${BASH_SOURCE[0]}))"
fi

export PATH="$NOMAD_PATH/bin:$PATH"

# Install Loop
for file in $NOMAD_PATH/install/*.sh; do
	echo -e "\nRunning installers: $file"
	source "$file"
done

sudo updatedb

gum confirm "Installation complete. reboot?" && reboot
