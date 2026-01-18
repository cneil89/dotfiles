
# Turn on bluetooth by default
echo -e "\tEnabling services"
sudo systemctl enable --now bluetooth.service

# Setup Docker
echo -e "\tSetting up docker"
sudo mkdir -p /etc/docker
echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json
sudo systemctl enable docker
sudo usermod -aG docker ${USER}

# Setup additional fonts
echo -e "\tSetting up fonts"
mkdir -p ~/.local/share/fonts
if ! fc-list | grep -qi "FiraCode Nerd Font"; then
	cd /tmp
	wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
	unzip FiraCode.zip -d FiraCode
	cp FiraCode/FiraCodeNerdFont-Regular.ttf ~/.local/share/fonts
	cp FiraCode/FiraCodeNerdFont-Bold.ttf ~/.local/share/fonts
	cp FiraCode/FiraCodeNerdFont-Light.ttf ~/.local/share/fonts
	cp FiraCode/FiraCodeNerdFont-Medium.ttf ~/.local/share/fonts
	cp FiraCode/FiraCodeNerdFont-Retina.ttf ~/.local/share/fonts
	cp FiraCode/FiraCodeNerdFont-SemiBold.ttf ~/.local/share/fonts
	rm -rf FiraCode.zip FiraCode
	fc-cache
	cd ~
fi

# Setup power profile
echo -e "\tSetting up power profiles"
if ls /sys/class/power_supply/BAT* &>/dev/null; then
	# This computer is running on a battery
	powerprofilesctl set balanced || true
else
	# this computer runs on a power outlet
	powerprofilesctl set performance || true
fi

## Setup Desktop
# Add screen rexorder based on GPU
echo -e "\tAdding screen recorder based on GPU"
if lspci | grep -qi 'nvidia'; then
    yay -S --noconfirm --needed wf-recorder
else
    yay -S --noconfirm --needed wl-screenrec
fi

echo -e "\tSetting up basic GTK/GNOME theming"
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface icon-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface cursor-theme "Adwaita-dark"

# Setup Config Files
echo -e "\tUsing Stow to setup config files"

REAL_USER=${SUDO_USER:-$USER}
REAL_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)

sudo -u "$REAL_USER" HOME="$REAL_HOME" NOMAD_PATH="$NOMAD_PATH" \
    bash -c '
PKGS_PARENT=$NOMAD_PATH/config
cd "$PKGS_PARENT"
for package in $PKGS_PARENT/*; do
	[ -d "$package" ] || continue ## Ensure directory, else continue
	pkg=$(basename "$package")
	echo -e "Stowing: $pkg"
	stow -d "$PKGS_PARENT" -t "$HOME" $pkg
done
'


# Setup media
echo -e "\tUpdating default app for media"
# Open all images with imv
xdg-mime default imv.desktop image/png
xdg-mime default imv.desktop image/jpeg
xdg-mime default imv.desktop image/gif
xdg-mime default imv.desktop image/webp
xdg-mime default imv.desktop image/bmp
xdg-mime default imv.desktop image/tiff

# Open PDFs with the Document Viewer
xdg-mime default org.gnome.Evince.desktop application/pdf

# Use Chromium as the default browser
xdg-settings set default-web-browser chromium.desktop
xdg-mime default chromium.desktop x-scheme-handler/http
xdg-mime default chromium.desktop x-scheme-handler/https

# Open video files with mpv
xdg-mime default mpv.desktop video/mp4
xdg-mime default mpv.desktop video/x-msvideo
xdg-mime default mpv.desktop video/x-matroska
xdg-mime default mpv.desktop video/x-flv
xdg-mime default mpv.desktop video/x-ms-wmv
xdg-mime default mpv.desktop video/mpeg
xdg-mime default mpv.desktop video/ogg
xdg-mime default mpv.desktop video/webm
xdg-mime default mpv.desktop video/quicktime
xdg-mime default mpv.desktop video/3gpp
xdg-mime default mpv.desktop video/3gpp2
xdg-mime default mpv.desktop video/x-ms-asf
xdg-mime default mpv.desktop video/x-ogm+ogg
xdg-mime default mpv.desktop video/x-theora+ogg
xdg-mime default mpv.desktop application/ogg

set -x
sudo mkdir -p /etc/sddm.conf.d

if [ ! -f /etc/sddm.conf.d/autologin.conf ]; then
  cat <<EOF | sudo -u "$REAL_USER" tee /etc/sddm.conf.d/autologin.conf
[Autologin]
User=$USER
Session=hyprland-uwsm

[Theme]
Current=breeze
EOF
fi

# Don't use chrootable here as --now will cause issues for manual installs
sudo systemctl enable sddm.service
set +x
