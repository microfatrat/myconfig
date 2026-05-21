# MyConfig

Personal dotfiles — Zsh shell config and [komorebi](https://github.com/LGUG2Z/komorebi) tiling window manager config for Windows.

## Quick Start

### Zsh

```bash
git clone git@github.com:microfatrat/myconfig.git ~/myconfig
ln -sf ~/myconfig/.zshrc ~/.zshrc
```

Or with GNU stow:

```bash
stow -t ~ -d ~/myconfig .
```

### Komorebi

```powershell
git clone git@github.com:microfatrat/myconfig.git "$env:USERPROFILE\myconfig"
# Then symlink or copy files as described in the Komorebi > Deploy section below
```

---
## Zsh

### Shell Options

| Feature | Behavior |
|---|---|
| **History** | 10,000 entries, instant sharing across terminals, duplicates filtered |
| **Auto-cd** | Type a directory name to jump into it |
| **Auto-pushd** | Directory stack managed automatically |
| **Extended glob** | Advanced pattern matching (`^`, `#`, etc.) |
| **Auto-correct** | Typos in commands are corrected on the fly |

### Completions

- Caching for fast startup (`-C` flag skips security rechecks)
- Case-insensitive matching with smart delimiter handling
- Colored output matching `LS_COLORS`

### Aliases

| Alias | Command | Notes |
|---|---|---|
| `ll` | `ls -alF` | Full detail with type indicators |
| `la` | `ls -A` | All files except `.` and `..` |
| `l` | `ls -CF` | Column view with type suffixes |
| `..` | `cd ..` | Up one level |
| `...` | `cd ../..` | Up two levels |
| `-` | `cd -` | Previous directory |
| `d` | `dirs -v` | Show directory stack |
| `cp` | `cp -iv` | Interactive & verbose |
| `mv` | `mv -iv` | Interactive & verbose |
| `rm` | `rm -i` | Interactive (safety net) |
| `mkdir` | `mkdir -p` | Create parent dirs |
| `grep` | `grep --color=auto` | Highlighted matches |

`ls` is automatically colorized depending on your OS (`--color=auto` on Linux, `-G` on macOS).

### Key Bindings

| Key | Action |
|---|---|
| `Home` | Beginning of line |
| `End` | End of line |
| `Delete` | Delete character |
| `Ctrl+Right` | Forward one word |
| `Ctrl+Left` | Backward one word |
| `Ctrl+R` | Incremental history search |

### Prompt

- **Left**: `user@host` (cyan), `cwd` (green), `%`/`#` (yellow)
- **Right**: Current time (magenta)

### Plugins

The following plugins are auto-loaded if installed:

- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) — fish-like syntax highlighting
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) — command suggestions from history

Checked paths (in order): `/usr/share/zsh/plugins`, `/usr/local/share`, `/usr/share`

### Requirements

- Zsh 5.0+
- For plugins: `apt install zsh-syntax-highlighting zsh-autosuggestions`

## Komorebi

### Requirements

- [komorebi](https://github.com/LGUG2Z/komorebi) (via `winget` or `scoop`)
- [komorebi-bar](https://github.com/LGUG2Z/komorebi-bar) (optional, for the status bar)
- [whkd](https://github.com/LGUG2Z/whkd) (for hotkey bindings)

### Deploy

```powershell
# Symlink config into %USERPROFILE% (requires admin / Developer Mode)
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\komorebi.json" -Target "$env:USERPROFILE\myconfig\komorebi\komorebi.json" -Force
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\komorebi.bar.json" -Target "$env:USERPROFILE\myconfig\komorebi\komorebi.bar.json" -Force
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\whkdrc" -Target "$env:USERPROFILE\myconfig\komorebi\whkdrc" -Force
```

Or simply copy the files if symlinks aren't available.

### komorebi.json — Window Manager

| Setting | Value |
|---|---|
| Layout | BSP (Binary Space Partition) |
| Border | Enabled, width 4px, offset -1, style `Square` |
| Padding | Container 4px, workspace 4px |
| Animation | 120ms, EaseInOutSine, 60fps |
| Cross-monitor move | Swap |

**Workspaces:**

| # | Name | Layout Rules |
|---|---|---|
| 1 | home | — |
| 2 | term | — |
| 3 | code | `Zed.exe` |
| 4 | web | `msedge.exe` |
| 5 | chat | `QQ.exe`, `WeChat.exe` |
| 6 | game | — |
| 7 | misc | — |

**Border colours:**

| State | Color |
|---|---|
| Focused (single) | `#89B4FA` (blue) |
| Stack | `#F38BA8` (pink) |
| Monocle | `#A6E3A1` (green) |
| Unfocused | `#585B70` (grey) |

**Floating apps:** Task Manager, Settings, Calculator, Snipping Tool, Steam popups.

### komorebi.bar.json — Status Bar

- **Font:** JetBrains Mono, Base16-Ashes theme
- **Left:** Workspace indicators, layout, focused window (with icon)
- **Right:** Media, Storage, Memory, Network (with activity), Date, Time (24h)

### whkdrc — Hotkeys

| Shortcut | Action |
|---|---|
| `Alt + 1-7` | Switch workspace |
| `Alt + Shift + 1-7` | Move window to workspace |
| `Alt + H/J/K/L` | Focus left/down/up/right |
| `Alt + Shift + H/J/K/L` | Move window |
| `Alt + Ctrl + H/J/K/L` | Resize window |
| `Alt + V` | BSP layout |
| `Alt + Shift + V` | Vertical stack |
| `Alt + M` | Toggle monocle |
| `Alt + F` | Toggle float |
| `Alt + [` / `Alt + ]` | Cycle focus prev/next |
| `Alt + Shift + [` / `]` | Cycle stack prev/next |
| `Alt + Return` | Promote window |
| `Alt + Q` | Close window |
| `Alt + R` | Retile |
| `Alt + Shift + Space` | Pause/Resume tiling |
| `Alt + X` / `Alt + Shift + X` | Flip layout horizontal/vertical |
| `Alt + Ctrl + 1-7` | Send to workspace & follow |

## License

This is a personal configuration — feel free to use, modify, and share.
