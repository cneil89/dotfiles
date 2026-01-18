sudo pacman -S --needed --noconfirm base-devel git

if ! command -v yay &>/dev/null; then
	git clone https://aur.archlinux.org/yay-bin.git /tmp/yay
	cd /tmp/yay
	makepkg -si --noconfirm
	cd ~
	rm -rf /tmp/yay
fi
