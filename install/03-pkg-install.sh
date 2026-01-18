#!/usr/bin/env bash
set -euo pipefail

# --- Configuration ---
PACKAGES_FILE="${NOMAD_PATH}/install/base.packages"

# --- Validate file existence ---
if [[ ! -f "$PACKAGES_FILE" ]]; then
  echo "ERROR: Packages file not found at: $PACKAGES_FILE" >&2
  exit 1
fi

# --- Parse packages: strip comments and empty lines ---
mapfile -t ALL_PKGS < <(awk '
  { sub(/#.*/, ""); gsub(/[ \t]+$/, "", $0); }
  NF { print $1 }
' "$PACKAGES_FILE")

if [[ ${#ALL_PKGS[@]} -eq 0 ]]; then
  echo "No packages found in $PACKAGES_FILE (after stripping comments)." >&2
  exit 0
fi

# --- Separate official vs AUR packages ---
OFFICIAL_PKGS=()
AUR_PKGS=()

for pkg in "${ALL_PKGS[@]}"; do
  if pacman -Si "$pkg" &>/dev/null; then
    OFFICIAL_PKGS+=("$pkg")
  else
    AUR_PKGS+=("$pkg")
  fi
done

# --- Filter out packages already installed ---
is_installed() {
  pacman -Q "$1" &>/dev/null
}

INSTALLED_PKGS=()
TO_INSTALL_OFFICIAL=()
TO_INSTALL_AUR=()

for pkg in "${OFFICIAL_PKGS[@]}"; do
  if is_installed "$pkg"; then
    INSTALLED_PKGS+=("$pkg")
  else
    TO_INSTALL_OFFICIAL+=("$pkg")
  fi
done

for pkg in "${AUR_PKGS[@]}"; do
  if is_installed "$pkg"; then
    INSTALLED_PKGS+=("$pkg")
  else
    TO_INSTALL_AUR+=("$pkg")
  fi
done

# --- Display summary ---
echo "=========================================="
echo " Package Installer"
echo "=========================================="
echo " Total packages listed : ${#ALL_PKGS[@]}"
echo " Already installed      : ${#INSTALLED_PKGS[@]}"
echo " Official to install    : ${#TO_INSTALL_OFFICIAL[@]}"
echo " AUR to install         : ${#TO_INSTALL_AUR[@]}"
echo "------------------------------------------"

if [[ ${#INSTALLED_PKGS[@]} -gt 0 ]]; then
  echo " ✅ Already installed:"
  printf '    %s\n' "${INSTALLED_PKGS[@]}"
  echo
fi

# --- Install official packages ---
if [[ ${#TO_INSTALL_OFFICIAL[@]} -gt 0 ]]; then
  echo "==> Installing official repo packages..."
  sudo pacman -S --noconfirm --needed "${TO_INSTALL_OFFICIAL[@]}"
else
  echo "==> No official packages to install."
fi

# --- Install AUR packages ---
if [[ ${#TO_INSTALL_AUR[@]} -gt 0 ]]; then
  if command -v yay >/dev/null 2>&1; then
    echo "==> Installing AUR packages with yay..."
    printf '   %s\n' ${TO_INSTALL_AUR[@]}
    # yay -S --noconfirm --needed "${TO_INSTALL_AUR[@]}"
  else
    echo "⚠️  The following AUR packages require yay (not installed):"
    printf '    %s\n' "${TO_INSTALL_AUR[@]}"
  fi
else
  echo "==> No AUR packages to install."
fi

echo
echo "🎉 Installation complete!"

