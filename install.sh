#!/usr/bin/env bash
set -euo pipefail
repo="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
target_home="${DOTFILES_TARGET_HOME:-$HOME}"
[[ -d "$repo/linux" ]] || { echo 'Linux files missing; run git sparse-checkout set shared linux' >&2; exit 1; }
backup="$target_home/.dotfiles-backups/$(date +%Y%m%d-%H%M%S)-$$"
while IFS= read -r -d '' source; do
 relative="${source#"$repo/linux/"}"
 target="$target_home/$relative"
 if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then continue; fi
 if [[ "${1:-}" == '--dry-run' ]]; then printf 'LINK %s -> %s\n' "$target" "$source"; continue; fi
 if [[ -e "$target" || -L "$target" ]]; then
  mkdir -p -- "$(dirname -- "$backup/$relative")"
  mv -- "$target" "$backup/$relative"
 fi
 mkdir -p -- "$(dirname -- "$target")"
 ln -s -- "$source" "$target"
done < <(find "$repo/linux" -type f -print0)
printf 'Done. Backups: %s\n' "$backup"
