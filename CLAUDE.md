# CLAUDE.md

This file provides guidance to Claude Code when working with this dotfiles repository.

## Bash Commands

```bash
# IMPORTANT: Deploy configurations using GNU Stow
stow                    # Deploy all configurations 
stow vim               # Deploy specific configuration
stow zsh lazyvim       # Deploy multiple configurations

# Initial setup (MUST use --recurse-submodules)
git clone --recurse-submodules https://github.com/Pagliacii/dotfiles
cd dotfiles
git submodule update --init

# Core dependencies setup
brew install zsh starship fzf ripgrep fd bat lsd
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
rm ~/.zshrc && stow zsh && source ~/.zshrc

# Python environment
brew install pyenv pyenv-virtualenv
pyenv install 3.11.0  # Replace with desired version

# Doom Emacs
stow doom-emacs && ~/.emacs.d/bin/doom install
```

## Core Files

- `README.org` - Complete setup guide with dependencies
- `lazyvim/.config/nvim/lua/plugins/*.lua` - 30+ modular Neovim plugin configs
- `lazyvim/.config/nvim/lazy-lock.json` - Plugin version lockfile (DO NOT manually edit)
- `zsh/.zshrc` - Shell configuration with Oh My Zsh
- `my_scripts/.local/bin/` - Custom utilities (screenshot, emacsc)

## Code Style & Architecture

**GNU Stow Structure**: Each directory = deployable configuration package
- `lazyvim/` - Primary Neovim editor (LazyVim framework)
- `zsh/` + `starship/` - Shell environment chain  
- `tmux/`, `alacritty/`, `wezterm/` - Terminal configurations
- `windows/` - Windows-specific configs (AutoHotkey, GlazeWM)

**LazyVim Plugin Organization**: Files in `lazyvim/.config/nvim/lua/plugins/` grouped by function:
- Core: `lazy.lua`, `lspconfig.lua`, `treesitter.lua`
- Development: `coding.lua`, `git.lua`, `debug.lua`, `ai.lua`
- Interface: `ui.lua`, `editor.lua`, `telescope.lua`, `fzf.lua`

## Workflow

**IMPORTANT: Always use GNU Stow for deployment - never manually copy files**

**Plugin Management**: LazyVim handles everything automatically via `lazy-lock.json`. Never manually install/update plugins.

**Dependencies**: This repository assumes Homebrew + modern CLI tools (fzf, ripgrep, fd, bat, lsd) are available.

**Testing**: No automated tests - verify configurations by deploying to clean environment.

## Repository Etiquette  

- Clone with `--recurse-submodules` (REQUIRED)
- Use `stow` for all deployments  
- Keep plugin modifications in `lazyvim/.config/nvim/lua/plugins/*.lua`
- Windows users: Use `windows/` directory for platform-specific configs
- Follow existing file organization patterns

## Unexpected Behaviors

- **Submodules**: Some components use git submodules - always clone with `--recurse-submodules`
- **LazyVim Updates**: Plugin versions locked in `lazy-lock.json` - updates handled by LazyVim, not manually
- **Cross-Platform**: Primary target is Unix/Linux/macOS - Windows support is secondary
- **Oh My Zsh**: Shell config expects Oh My Zsh framework - will not work with plain zsh