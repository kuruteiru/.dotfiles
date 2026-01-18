#!/bin/bash

set -euo pipefail
sudo -v
echo -e "sysinstall wip"

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

libs=(
	"fuse-libs"
)

essential_packages=(
	"git"
	"git-extras/git-core"
	"github-cli"

	"ghostty"
	"tmux"
	"tmuxifier"

	"nvim"
	"clang"
	"cmake"

	"zen"
	"librewolf"
	"brave"

	"bitwarden"
	"libreoffice"
	"vlc"
	"imv"

	"fzf"
	"btop"
	"fastfetch"
	"trash-cli"
	"grim"
	"slurp"
	"tlp"

	"NetworkManager"
)

optional_packages=(
	"binaryninja"
	"veracrypt"
	"protonvpn"

	"zoxide"
	"dash"

	"discord"
	"obsidian"
	"zathura"
	"thunderbird"
	"ticktick"
	"spotify"

	"steam"
	"wine"
	"lutris"
	"blender"
)

fdc_packages=(
	"remmina"
)

ok() {
	echo -e "${GREEN}[OK]${NC} $1"
}

warning() {
	echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
	echo -e "${RED}[ERROR]${NC} $1"
}

not_implemented() {
	error "${FUNCNAME[0]} not implemented"
}

install_essential_packages() {
	not_implemented
	for item in "${essential_packages[@]}"; do
		ok "$item"
	done
}

install_optional_packages() {
	not_implemented
	for item in "${optional_packages[@]}"; do
		ok "$item"
	done
}

install_libs() {
	not_implemented
	for item in "${libs[@]}"; do
		ok "$item"
	done
}

install_special() {
	not_implemented
	# veracrypt
	# binaryninja
}

install_nerdfont() {
	not_implemented
}

install_dotfiles() {
	cd ~
	git clone git@github.com:kuruteiru/.dotfiles.git
	./.dotfiles/install.sh
}

install_scripts() {
	cd ~
	git clone git@github.com:kuruteiru/scripts.git
}

install_nvidia_drivers() {
	not_implemented
}

setup_boot_config() {
	not_implemented
	# /etc/default/grub
	# /etc/dracut.conf.d/10-bluetooth-pairing.conf
	# /etc/crypttab
}
