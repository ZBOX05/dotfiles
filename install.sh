#!/bin/bash

#----------------------------------------------------
# Dotfiles Install Script
#----------------------------------------------------

# 变量定义
#----------------------------------------------------
# dotfiles 仓库的目录 (脚本所在的目录)
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
# 用户的 Home 目录
HOME_DIR=$HOME


# 需要创建符号链接的文件/目录列表
# 格式："仓库中的路径;系统中的目标路径"
# 注意：目标路径中的 ~ 会被自动替换为 $HOME_DIR
#----------------------------------------------------
files_to_link=(
    ".zshrc;~/.zshrc"
    ".config/nvim;~/.config/nvim"
    ".config/tmux;~/.config/tmux"
    ".config/starship.toml;~/.config/starship.toml"
)


# 主逻辑
#----------------------------------------------------
echo "🚀 Starting dotfiles setup..."

for item in "${files_to_link[@]}"; do
    # 分割源文件和目标文件路径
    IFS=';' read -r source_path target_path <<< "$item"

    # 将 ~ 替换为真实的主目录路径
    expanded_target_path="${target_path/#\~/$HOME_DIR}"
    full_source_path="$DOTFILES_DIR/$source_path"

    # 检查源文件是否存在于仓库中
    if [ ! -e "$full_source_path" ]; then
        echo "🟡 WARNING: Source file not found in dotfiles repo, skipping: $source_path"
        continue
    fi

    # 检查目标位置是否已经存在
    if [ -e "$expanded_target_path" ]; then
        # 如果它不是一个符号链接，就备份它
        if [ ! -L "$expanded_target_path" ]; then
            echo " Backing up existing file: $expanded_target_path -> ${expanded_target_path}.bak"
            mv "$expanded_target_path" "${expanded_target_path}.bak"
        else
            # 如果它已经是一个符号链接，我们就先移除它，以便创建新的
            echo " Removing existing symlink: $expanded_target_path"
            rm "$expanded_target_path"
        fi
    fi

    # 创建父目录 (如果不存在的话)
    mkdir -p "$(dirname "$expanded_target_path")"

    # 创建符号链接
    echo "🔗 Linking $expanded_target_path -> $full_source_path"
    ln -s "$full_source_path" "$expanded_target_path"

done

echo "✅ Dotfiles setup complete!"
echo "Please restart your shell (or run 'source ~/.zshrc') to apply changes."
