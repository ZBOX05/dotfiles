# 计时起点
$ProfileStart = Get-Date

# 1. 基础配置
Set-PSReadLineOption -EditMode Vi
$env:EZA_CONFIG_DIR = "$env:USERPROFILE\.config\eza"

# 2. 别名
Set-Alias nn nvim
Set-Alias nivm nvim
Set-Alias ftch fastfetch
Set-Alias yy yazi
Set-Alias rwsl Restart-WSL
Set-Alias ls eza
Set-Alias l "eza -lah --icons --git"
Set-Alias cat bat
Set-Alias grep rg
Set-Alias ripgrep rg
Set-Alias du dust
Set-Alias ping gping

# 3. 环境变量 (⚠️ 记得填入你的新 Key)

function Restart-WSL {
    wsl --shutdown; wsl ~
}
function swsl { wsl --shutdown }

# 4. 极致加速：缓存 Starship 和 Zoxide
$CacheDir = "$env:LOCALAPPDATA\Temp\PowerShellCache"
$StarshipCache = "$CacheDir\starship.init.ps1"
$ZoxideCache = "$CacheDir\zoxide.init.ps1"

if (Test-Path $StarshipCache) {
    . $StarshipCache
} else {
    New-Item -Path $CacheDir -ItemType Directory -Force | Out-Null
    starship init powershell | Out-File -FilePath $StarshipCache -Encoding utf8
    . $StarshipCache
}

if (Test-Path $ZoxideCache) {
    . $ZoxideCache
} else {
    zoxide init powershell | Out-File -FilePath $ZoxideCache -Encoding utf8
    . $ZoxideCache
}

# 5. 懒加载优化 (Lazy Load) - PSFzf
# 启动时不加载，直到你按下 Ctrl+R 才加载
Set-PSReadLineKeyHandler -Key 'Ctrl+r' -ScriptBlock {
    Write-Host -NoNewline " Loading Fzf..." -ForegroundColor DarkGray
    Import-Module PSFzf
    Set-PSFzfOption -InvokeHistoryKeys 'Ctrl+R'
    Invoke-FuzzyHistory
}

# 6. Windows Terminal 集成
Import-Module wt-shell-integration -ErrorAction SilentlyContinue

# 7. 被优化掉的模块 (注释保留)
# Import-Module -Name Microsoft.WinGet.CommandNotFound

# 8. 视觉组件 (注释掉)
# fastfetch

# 计时终点
$ProfileEnd = Get-Date
$Duration = $ProfileEnd - $ProfileStart
Write-Host ("Shell initialized in {0:F3}s" -f $Duration.TotalSeconds)
# Private overrides are intentionally outside the repository.
if (Test-Path "$HOME/.config/powershell/local.ps1") { . "$HOME/.config/powershell/local.ps1" }
