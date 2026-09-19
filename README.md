# Dotfiles — Windows / Linux

一个仓库，只检出当前系统配置。新机器打开本页复制对应入口即可，不必记 Git 参数。

## Windows

先安装 Git 和 PowerShell 7，在 PowerShell 执行：

```powershell
$setup = Join-Path $env:TEMP ('dotfiles-' + [guid]::NewGuid() + '.ps1')
Invoke-WebRequest https://raw.githubusercontent.com/ZBOX05/dotfiles/main/bootstrap.ps1 -OutFile $setup
pwsh -NoProfile -ExecutionPolicy Bypass -File $setup
```

## Linux

先安装 Git、Bash 和 curl：

```bash
setup="$(mktemp)" && curl -fsSL https://raw.githubusercontent.com/ZBOX05/dotfiles/main/bootstrap.sh -o "$setup" && bash "$setup"
```

默认保存到 `~/dotfiles`。已有同名目录时停止，不覆盖已有仓库。入口使用 partial clone + sparse checkout：Windows 检出 `shared/ windows/`，Linux 检出 `shared/ linux/`；根目录的小脚本和说明两边可见。Git 元数据包含历史，这不是隐私隔离机制。

## 安装和更新

安装前关闭相关应用。Windows 按 `windows/manifest.json` 逐文件复制，无需管理员或开发者模式；Linux 逐文件建立软链接。冲突文件先备份至 `~/.dotfiles-backups/时间戳/`，不删除未管理的文件。恢复时关闭应用，将对应备份移回原位置。

预览：Windows `./install.ps1 -DryRun`；Linux `bash install.sh --dry-run`。

更新：Windows `& "$HOME/dotfiles/update.ps1"`；Linux `bash ~/dotfiles/update.sh`。Windows 更新重新部署仓库版本并备份本机差异；在应用中修改配置后，需手动同步到仓库再提交。Linux 链接修改直接反映到仓库。安装不自动安装软件、字体、插件或启动后台程序。

## 收录范围

Windows：Terminal、GlazeWM、YASB、PowerShell、Neovim、Yazi、Starship、Eza、Fastfetch、VS Code 设置/快捷键/扩展清单、AutoHotkey、AltSnap、WSL。

Linux：保留原仓库的 Bash、Zsh、Neovim、tmux、Yazi、Starship、lazygit 配置，移除会话、备份和下载残留。两边存在差异的配置独立保留，`shared/` 预留给确实共用的配置。

不收录登录数据、聊天记录、浏览历史、终端输出、用户词频、私钥、API 令牌、缓存和应用数据库。未整目录复制浏览器、聊天/AI 客户端、代理客户端、SSH、输入法用户数据。

## 还原体验的依赖和差异

- 字体：Iosevka Nerd Font Mono；主题：Everforest。
- 工具：PowerShell 7、Starship、Zoxide、Eza、Neovim、Yazi、Git、ripgrep、fzf、bat、dust、gping、Fastfetch。
- PowerShell 模块：PSReadLine、PSFzf、wt-shell-integration。
- 桌面：Windows Terminal、GlazeWM、YASB、AutoHotkey v2、AltSnap。
- AutoHotkey 脚本部署至 `~/.config/autohotkey/`，需手动启动或设自启。
- Neovim 插件由 lazy.nvim 管理；Yazi 插件清单见各平台 package.toml；VS Code 扩展清单为 `windows/vscode/extensions.txt`，可执行 `Get-Content ~/dotfiles/windows/vscode/extensions.txt | ForEach-Object { code --install-extension $_ }`。
- Linux 的 Zsh 需要 Oh My Zsh，tmux 插件需要 TPM；按配置中声明的列表安装插件。
- Terminal 的 WSL Ubuntu-24.04、MSYS2 配置需要安装对应软件。E: 程序路径、GlazeWM 双显示器布局、WSL 8GB 内存上限需按新机器调整。
- GlazeWM 的 AutoTile 启动命令依赖 E: 下的外部 Python 项目及虚拟环境，未打包该项目；新机器需安装并修改路径，或禁用对应启动项。
- YASB 天气需要私有环境变量，现有配置还引用 komorebi；请按实际使用的窗口管理器调整。
- VS Code 的个人云项目标识、版本绑定的动画注入路径已移除；动画扩展需重新启用。
- AI 登录、Git 身份、MCP 连接和令牌需自行配置。PowerShell 私有覆盖放在 `~/.config/powershell/local.ps1`（不入库）。

## 隐私检查

2026-09-20 检查了既有 5 个提交可达的文本对象及 tmux 压缩快照：未匹配到明确凭据，但旧历史存在终端输出、用户名/主机名、项目路径和提交邮箱。当前版本移除不等于清除历史；此次没有强制推送或历史重写。部分 ripgrep 临时下载包损坏，无法完整展开，已从当前版本移除。

Windows 导出副本已移除 PowerShell 明文令牌、VS Code 个人云项目标识和 Terminal 的固定用户路径；Git 全局身份配置未上传。原机配置未修改。扫描与人工复核不保证识别所有形式的敏感信息。
