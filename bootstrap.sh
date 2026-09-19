#!/usr/bin/env bash
set -euo pipefail
dest="${1:-$HOME/dotfiles}"
command -v git >/dev/null || { echo 'Install Git first.' >&2; exit 1; }
[[ ! -e "$dest" ]] || { echo "Destination exists: $dest; use update.sh" >&2; exit 1; }
git clone --filter=blob:none --sparse --branch main https://github.com/ZBOX05/dotfiles.git "$dest"
git -C "$dest" sparse-checkout set shared linux
bash "$dest/install.sh"
