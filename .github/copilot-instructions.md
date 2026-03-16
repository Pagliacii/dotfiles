# Copilot Instructions for Pagliacii/dotfiles

## What This Repository Is

This is a **personal dotfiles repository** for managing system configurations across Unix/Linux/macOS (primary) and Windows (secondary). It uses **GNU Stow** for symlink-based deployment — most top-level directories are self-contained "stow packages" that mirror the home directory structure.

There are **no build steps, no CI/CD pipelines, no automated tests, and no compiled artifacts**. Changes are validated by deploying configurations to a real system.

## Repository Architecture

### GNU Stow Package Layout

Most top-level directories that contain dotfiles are deployable stow packages (for example, `lazyvim/`, `zsh/`, `tmux/`). Some top-level directories are not stow packages, such as `img/` (README assets) and `config_files/` (shared configs). When you run `stow <package>`, it creates symlinks from the package contents into `$HOME`. The internal structure mirrors the home directory:

```
<package>/
├── .config/<app>/     → ~/.config/<app>/
├── .local/bin/        → ~/.local/bin/
├── .<dotfile>         → ~/.<dotfile>
```

### Key Packages

| Package | Purpose | Key Files |
|---------|---------|-----------|
| `lazyvim/` | Primary Neovim editor (LazyVim framework) | `.config/nvim/lua/plugins/*.lua` (39 plugin files), `lazy-lock.json` |
| `zsh/` | Shell environment (Oh My Zsh) | `.zshrc` |
| `starship/` | Cross-shell prompt | `.config/starship.toml` |
| `tmux/` | Terminal multiplexer | `.config/tmux/` |
| `vim/` | Traditional Vim editor | `.vim/` with 20+ `.conf` plugin configs |
| `wezterm/` | Terminal emulator (Lua config) | `.config/wezterm/` |
| `alacritty/` | Terminal emulator | `.config/alacritty/` |
| `zellij/` | Terminal multiplexer (Rust-based) | `.config/zellij/` |
| `doom-emacs/` | Doom Emacs config (submodule) | `.doom.d/`, `.emacs.d/` |
| `spacemacs/` | Spacemacs config (submodule) | `.emacs.d/` |
| `glazewm/` | Windows tiling WM | `.glaze-wm/` |
| `kanata/` | Keyboard remapping | `.config/kanata/` |
| `my_scripts/` | Custom shell scripts | `.local/bin/` (screenshot, emacsc, lock, enable-goproxy.sh) |
| `windows/` | Windows-specific (AutoHotkey v2.0) | `AutoHotkey.ahk` |
| `yazi/` | Terminal file manager | `.config/yazi/` |
| `ranger/` | File manager (submodule for devicons) | `.config/ranger/` |
| `golang/` | Go environment config | `.config/go/env` |
| `pip/` | pip package manager config | `.config/pip/pip.conf` |
| `cheat.sh/` | cheat.sh CLI + zsh completion | `.local/bin/cht.sh`, `.zsh.d/_cht` |

### Git Submodules

This repository uses **8 git submodules** (defined in `.gitmodules`):
- `spacemacs/.emacs.d` — Spacemacs framework
- `doom-emacs/.emacs.d` — Doom Emacs framework
- `ranger/.config/ranger/plugins/ranger_devicons` — Ranger file icons
- `zsh/.oh-my-zsh/custom/plugins/zsh-wakatime` — Wakatime tracking
- `zsh/.oh-my-zsh/custom/plugins/fzf-tab` — FZF tab completion
- `zsh/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting` — Syntax highlighting
- `zsh/.oh-my-zsh/custom/plugins/zsh-autosuggestions` — Autosuggestions
- `zsh/.oh-my-zsh/custom/plugins/zsh-nvm` — NVM integration

**Always clone with `--recurse-submodules`**. If already cloned, run `git submodule update --init`.

## Critical Rules

1. **Use GNU Stow for deployment** — never manually copy or symlink files. Deploy with `stow <package>` or just `stow` for all packages.
2. **Do NOT manually edit `lazyvim/.config/nvim/lazy-lock.json`** — this lockfile is managed by LazyVim's plugin manager automatically.
3. **Preserve the stow package directory structure** — new config files must mirror the home directory path inside their package directory (e.g., a config for `~/.config/foo/bar.toml` goes in `foo/.config/foo/bar.toml`).
4. **Follow existing file organization** — LazyVim plugins go in `lazyvim/.config/nvim/lua/plugins/`, shell configs in `zsh/`, etc.
5. **Windows-specific configs go in `windows/` or `glazewm/` or `kanata/`** — do not mix platform-specific files into Unix packages.

## LazyVim Plugin Organization

Plugin files in `lazyvim/.config/nvim/lua/plugins/` are organized by function:

- **Core**: `lazy.lua`, `lspconfig.lua`, `treesitter.lua`
- **Development**: `coding.lua`, `git.lua`, `debug.lua`, `ai.lua`, `rest.lua`
- **Interface**: `ui.lua`, `editor.lua`, `telescope.lua`, `fzf.lua`, `colorscheme.lua`, `symbols.lua`, `window.lua`
- **Tools**: `terminal.lua`, `file.lua`, `search.lua`, `markdown.lua`, `formatting.lua`, `linter.lua`, `snips.lua`, `shell.lua`, `database.lua`
- **Workflow**: `command.lua`, `keyboard.lua`, `eval.lua`, `writing.lua`, `documentation.lua`, `embedded.lua`, `note.lua`, `project.lua`
- **Utility**: `util.lua`
- **Language extras** (in `extras/lang/`): `python.lua`, `rust.lua`, `golang.lua`, `lua.lua`, `nix.lua`, `protobuf.lua`

### Lua Style for LazyVim Plugins

- Formatter: **StyLua** (`stylua.toml`: 2-space indent, 120-column width, sorted requires)
- Linter: **Selene** (`selene.toml`)
- Each plugin file returns a Lua table of plugin specs following the [lazy.nvim plugin spec format](https://lazy.folke.io/spec)
- The entry point is `lazyvim/.config/nvim/init.lua` which bootstraps `config.lazy`

## Shell Configuration

- **Framework**: Oh My Zsh (required — plain zsh will not work)
- **41 Oh My Zsh plugins** enabled in `.zshrc`
- **Prompt**: Starship (initialized via Homebrew)
- **Editor**: `vim` (set via `$EDITOR` and `$VISUAL`)
- **Core CLI tools required**: fzf, ripgrep, fd, bat, lsd, autojump
- **Python**: managed via pyenv + pyenv-virtualenv
- **History**: 10M entries, deduped, shared across sessions

## Making Changes

### Adding a New Configuration Package

1. Create a new top-level directory named after the tool (e.g., `newtool/`)
2. Inside it, mirror the home directory structure (e.g., `newtool/.config/newtool/config.toml`)
3. Deploy with `stow newtool`

### Modifying LazyVim Plugins

1. Find or create the appropriate plugin file in `lazyvim/.config/nvim/lua/plugins/`
2. Follow the existing pattern: return a table of lazy.nvim plugin specs
3. Format with StyLua if available (`stylua lazyvim/.config/nvim/lua/plugins/your_file.lua`)

### Modifying Shell Configuration

1. Edit `zsh/.zshrc` for shell changes
2. Edit `starship/.config/starship.toml` for prompt changes
3. New shell plugins should be added as submodules under `zsh/.oh-my-zsh/custom/plugins/`

### Adding Custom Scripts

Place executable scripts in `my_scripts/.local/bin/` — they deploy to `~/.local/bin/` which is on `$PATH`.

## Validation

There are no automated tests. To verify changes:

- **LazyVim**: Run `nvim` and check `:checkhealth` for errors
- **Zsh**: Source the config with `source ~/.zshrc` and check for warnings
- **Doom Emacs**: Run `~/.emacs.d/bin/doom doctor`
- **General**: Deploy with `stow <package>` and verify the symlinks are correct

## Dependencies

This repository assumes:
- **GNU Stow** for deployment
- **Homebrew** (linuxbrew) for package management
- **Oh My Zsh** framework for shell
- **Modern CLI tools**: fzf, ripgrep, fd, bat, lsd, tree, autojump
- **Python**: pyenv, pyenv-virtualenv, Poetry
- **Neovim** (0.9+) for LazyVim
- **Starship** prompt

## Workarounds and Known Issues

- **Neovim v0.12+ treesitter compatibility**: `lazyvim/.config/nvim/init.lua` contains a workaround that patches `vim.treesitter.get_parser()` to return a stub parser instead of nil. This prevents plugin crashes (rainbow-delimiters, nvim-treesitter-context, none-ls). This should be removed once upstream plugins add nil checks.
- **Shallow clone limitations**: The repository is often cloned with shallow history. Run `git fetch --unshallow origin` if full history is needed for operations like rebase.
- **Rust mirror**: `.zshrc` configures a Chinese mirror for rustup (`mirrors.tuna.tsinghua.edu.cn`). This may cause issues outside China — adjust `RUSTUP_DIST_SERVER` if needed.
