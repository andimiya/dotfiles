#!/bin/bash

zshrc() {
    echo "==========================================================="
    echo "             cloning zsh-autosuggestions                   "
    echo "-----------------------------------------------------------"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    echo "==========================================================="
    echo "             cloning zsh-syntax-highlighting               "
    echo "-----------------------------------------------------------"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    echo "==========================================================="
    echo "             import zshrc                                  "
    echo "-----------------------------------------------------------"
    cat .zshrc > $HOME/.zshrc
    echo "==========================================================="
    echo "             import powerlevel10k                          "
    echo "-----------------------------------------------------------"
    cat .p10k.zsh > $HOME/.p10k.zsh

}

zshrc

# make directly highlighting readable - needs to be after zshrc line
echo "" >> ~/.zshrc
echo "# remove ls and directory completion highlight color" >> ~/.zshrc
echo "_ls_colors=':ow=01;33'" >> ~/.zshrc
echo 'zstyle ":completion:*:default" list-colors "${(s.:.)_ls_colors}"' >> ~/.zshrc
echo 'LS_COLORS+=$_ls_colors' >> ~/.zshrc



# Dotfiles install script — runs automatically in GitHub Codespaces
# and can be run manually on any machine.

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Symlink copilot instructions for Copilot CLI
if [ -f "$DOTFILES_DIR/.github/copilot-instructions.md" ]; then
  mkdir -p "$HOME/.copilot"
  ln -sf "$DOTFILES_DIR/.github/copilot-instructions.md" "$HOME/.copilot/copilot-instructions.md"
  echo "✓ Linked copilot-instructions.md → ~/.copilot/copilot-instructions.md"
fi

git config --global push.autoSetupRemote true

echo "Dotfiles install complete."
