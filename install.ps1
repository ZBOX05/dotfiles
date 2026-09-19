param([switch]$DryRun, [string]$TargetHome = $HOME)
$ErrorActionPreference='Stop'
$roots=@{ HOME=$TargetHome; APPDATA=$env:APPDATA; LOCALAPPDATA=$env:LOCALAPPDATA; DOCUMENTS=[Environment]::GetFolderPath('MyDocuments') }
if ($TargetHome -ne $HOME) {
 $roots.APPDATA=Join-Path $TargetHome 'AppData/Roaming'
 $roots.LOCALAPPDATA=Join-Path $TargetHome 'AppData/Local'
 $roots.DOCUMENTS=Join-Path $TargetHome 'Documents'
}
$manifest=Get-Content -LiteralPath "$PSScriptRoot/windows/manifest.json" -Raw | ConvertFrom-Json
$backup=Join-Path $TargetHome ('.dotfiles-backups/'+(Get-Date -Format 'yyyyMMdd-HHmmss-ffff'))
foreach ($entry in $manifest) {
 $parts=$entry.target -split '/',2
 if (-not $roots.ContainsKey($parts[0]) -or $parts[1] -match '(^|/)\.\.(/|$)') { throw 'Invalid manifest target' }
 $source=Join-Path $PSScriptRoot $entry.source
 if (-not (Test-Path -LiteralPath $source -PathType Leaf)) { throw "Missing source: $source" }
 $target=Join-Path $roots[$parts[0]] $parts[1]
 if ((Test-Path -LiteralPath $target -PathType Leaf) -and ((Get-FileHash -LiteralPath $source).Hash -eq (Get-FileHash -LiteralPath $target).Hash)) { continue }
 if ($DryRun) { Write-Output "COPY $($entry.source) -> $target"; continue }
 if (Test-Path -LiteralPath $target) {
  $saved=Join-Path $backup $entry.target
  New-Item -ItemType Directory -Force -Path (Split-Path $saved) | Out-Null
  Move-Item -LiteralPath $target -Destination $saved
 }
 New-Item -ItemType Directory -Force -Path (Split-Path $target) | Out-Null
 Copy-Item -LiteralPath $source -Destination $target
}
Write-Output "Done. Changed files backed up under $backup. Restart affected apps."
