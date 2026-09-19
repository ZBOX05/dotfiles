param([string]$Destination = (Join-Path $HOME 'dotfiles'))
$ErrorActionPreference='Stop'
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw 'Install Git first.' }
if (Test-Path -LiteralPath $Destination) { throw 'Destination exists. Run its update.ps1 instead.' }
git clone --filter=blob:none --sparse --branch main https://github.com/ZBOX05/dotfiles.git $Destination
if ($LASTEXITCODE) { throw 'Clone failed' }
git -C $Destination sparse-checkout set shared windows
if ($LASTEXITCODE) { throw 'Sparse checkout failed' }
& (Join-Path $Destination 'install.ps1')
