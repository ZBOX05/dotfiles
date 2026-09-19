$ErrorActionPreference='Stop'
if (git -C $PSScriptRoot status --porcelain) { throw 'Commit or stash repository edits first.' }
git -C $PSScriptRoot pull --ff-only
if ($LASTEXITCODE) { throw 'Update failed' }
& "$PSScriptRoot/install.ps1"
