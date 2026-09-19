#!/usr/bin/env bash
set -euo pipefail
repo="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
[[ -z "$(git -C "$repo" status --porcelain)" ]] || { echo 'Commit or stash repository edits first.' >&2; exit 1; }
git -C "$repo" pull --ff-only
bash "$repo/install.sh"
