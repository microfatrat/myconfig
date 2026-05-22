# MyConfig

Personal dotfiles — Zsh shell config + [komorebi](https://github.com/LGUG2Z/komorebi) tiling window manager config for Windows.

---

## Directory Structure

```
myconfig/
├── .zshrc                     # Zsh shell configuration
├── README.md
└── komorebi/
    ├── komorebi.json          # Tiling window manager config
    ├── komorebi.bar.json      # Status bar config
    └── whkdrc                 # Hotkey bindings → ~/.config/whkdrc
```

---

## Quick Setup

```bash
git clone git@github.com:microfatrat/myconfig.git ~/myconfig
```

### Zsh (.zshrc)

```bash
ln -sf ~/myconfig/.zshrc ~/.zshrc
source ~/.zshrc
```

### Komorebi

```powershell
# 1. Create symlinks to map repo configs to komorebi's default paths

# Ensure the .config directory exists
New-Item -ItemType Directory -Path "$HOME\.config" -Force | Out-Null

# Window manager
New-Item -ItemType SymbolicLink `
    -Path "$HOME\komorebi.json" `
    -Target "$HOME\myconfig\komorebi\komorebi.json" `
    -Force

# Status bar
New-Item -ItemType SymbolicLink `
    -Path "$HOME\komorebi.bar.json" `
    -Target "$HOME\myconfig\komorebi\komorebi.bar.json" `
    -Force

# Hotkeys
New-Item -ItemType SymbolicLink `
    -Path "$HOME\.config\whkdrc" `
    -Target "$HOME\myconfig\komorebi\whkdrc" `
    -Force
```

```powershell
# 2. Start services
komorebic start          # Start tiling window manager
komorebic bar start      # Start status bar
whkd                     # Start hotkey daemon
```

```powershell
# 3. Hot-reload after editing configs (no restart needed)
komorebic reload-configuration
komorebic bar reload-configuration
whkd -r                  # Reload hotkey bindings
```

```powershell
# 4. Autostart (bar and whkd launch together with komorebi on login)

# Enable komorebi's built-in autostart (creates a Windows Scheduled Task)
komorebic enable-autostart

# Then edit the scheduled task: add --whkd --bar to the arguments
# Command: taskschd.msc  →  find "komorebi"  →  edit action to:
#   "C:\Program Files\komorebi\bin\komorebic-no-console.exe" start --whkd --bar
```

---

## .zshrc — Zsh Shell

### Requirements

- **Zsh** 5.0+
- Recommended packages:

```bash
# Required for plugins
sudo apt install zsh-fast-syntax-highlighting zsh-autosuggestions
# Or on Arch
sudo pacman -S zsh-fast-syntax-highlighting zsh-autosuggestions
```

### Shell Options

| Feature | Behavior |
|---|---|
| **History** | 10,000 entries, real-time sharing across terminals, duplicates filtered |
| **Auto-cd** | Type a directory name to jump into it |
| **Auto-pushd** | Directory stack managed automatically |
| **Extended glob** | Advanced pattern matching (`^`, `#`, etc.) |
| **Auto-correct** | Typos in commands corrected on the fly |

### Completions

- `compinit -C` for fast startup (skips security rechecks)
- Case-insensitive matching with smart delimiter handling
- Colored output matching `LS_COLORS`

### Aliases

#### File Listing

| Alias | Command | Notes |
|---|---|---|
| `ll` | `ls -alF` | Full detail with type indicators |
| `la` | `ls -A` | All files except `.` and `..` |
| `l` | `ls -CF` | Column view with type suffixes |

`ls` auto-colorizes based on OS (`--color=auto` on Linux, `-G` on macOS).

#### Safety (interactive + verbose)

| Alias | Expands to |
|---|---|
| `cp` | `cp -iv` |
| `mv` | `mv -iv` |
| `rm` | `rm -i` |
| `mkdir` | `mkdir -p` |

#### Navigation

| Alias | Action |
|---|---|
| `..` | `cd ..` |
| `...` | `cd ../..` |
| `-` | Go back to previous directory (`cd -`) |
| `d` | Show directory stack (`dirs -v`) |

#### Other

| Alias | Expands to |
|---|---|
| `grep` | `grep --color=auto` |

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

- **Left**: `user@host` (cyan) `current_dir` (green) `%`/`#` (yellow)
- **Right**: Current time (magenta)

### Plugins (auto-loaded if installed)

| Plugin | Package | Purpose |
|---|---|---|
| [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting) | `zsh-fast-syntax-highlighting` | Async syntax highlighting |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | `zsh-autosuggestions` | Command suggestions from history |

Search paths: `/usr/share/zsh/plugins` → `/usr/local/share` → `/usr/share`

---

## komorebi.json — Window Manager

### Requirements

- [komorebi](https://github.com/LGUG2Z/komorebi) (`winget install LGUG2Z.komorebi` or `scoop install komorebi`)

### Overview

| Setting | Value |
|---|---|
| **Layout** | BSP (Binary Space Partition) |
| **Border** | Enabled, 4px width, offset -1, style `Square` (Win10 rect) |
| **Padding** | Container 4px, workspace 4px |
| **Animation** | 120ms, EaseInOutSine, 60fps |
| **Cross-monitor move** | Swap |

### Workspaces (7 total)

| Key | Name | Layout Rule |
|---|---|---|
| `Alt+1` | home | — |
| `Alt+2` | term | — |
| `Alt+3` | code | `Zed.exe` |
| `Alt+4` | web | `msedge.exe` |
| `Alt+5` | chat | `QQ.exe`, `WeChat.exe` |
| `Alt+6` | game | — |
| `Alt+7` | misc | — |

### Border Colors

| State | Color | Hex |
|---|---|---|
| Single (focused) | Blue | `#89B4FA` |
| Stack | Pink | `#F38BA8` |
| Monocle | Green | `#A6E3A1` |
| Unfocused | Grey | `#585B70` |

### Floating / Unmanaged Apps

| App | Rule |
|---|---|
| Task Manager | `Taskmgr.exe` |
| Settings | `ApplicationFrameHost.exe` + Title `设置` |
| Calculator | `ApplicationFrameHost.exe` + Title `Calculator` |
| Snipping Tool | `SnippingTool.exe` |
| Steam popups | `steamwebhelper.exe` + Class `SDL_app` + Title starts `notificationtoasts` |

---

## komorebi.bar.json — Status Bar

### Requirements

- [komorebi-bar](https://github.com/LGUG2Z/komorebi-bar) (same installer as komorebi)

### Configuration

- **Font**: JetBrains Mono
- **Theme**: Base16-Ashes, accent `Base0D`

#### Left widgets

| Widget | Details |
|---|---|
| Komorebi | Workspace list (non-empty shown), layout indicator, focused window (with icon) |

#### Right widgets

| Widget | Details |
|---|---|
| Media | Enabled |
| Storage | Enabled |
| Memory | Enabled |
| Network | Enabled, show activity + total |
| Date | `DayDateMonthYear` format |
| Time | `TwentyFourHour` format |
| Battery | Disabled (desktop) |

### Start / Stop / Reload

```powershell
komorebic bar start
komorebic bar stop
komorebic bar reload-configuration
```

---

## whkdrc — Hotkey Bindings

### Requirements

- [whkd](https://github.com/LGUG2Z/whkd) (`winget install LGUG2Z.whkd` or `scoop install whkd`)

### Workspace

| Shortcut | Action |
|---|---|
| `Alt + 1-7` | Focus workspace |
| `Alt + Shift + 1-7` | Move window to workspace |
| `Alt + Ctrl + 1-7` | Send to workspace & follow |

### Focus / Move / Resize

| Shortcut | Action |
|---|---|
| `Alt + H/J/K/L` | Focus left/down/up/right |
| `Alt + Shift + H/J/K/L` | Move window |
| `Alt + Ctrl + H/J/K/L` | Resize window |
| `Alt + [` / `]` | Cycle focus previous/next |
| `Alt + Shift + [` / `]` | Cycle stack previous/next |

### Layout

| Shortcut | Action |
|---|---|
| `Alt + V` | BSP layout |
| `Alt + Shift + V` | Vertical stack |
| `Alt + M` | Toggle monocle |
| `Alt + F` | Toggle float |
| `Alt + Shift + F` | Add float rule |
| `Alt + X` | Flip layout horizontally |
| `Alt + Shift + X` | Flip layout vertically |

### Window & Misc

| Shortcut | Action |
|---|---|
| `Alt + Return` | Promote window |
| `Alt + Q` | Close window |
| `Alt + Shift + Q` | Force focus |
| `Alt + R` | Retile |
| `Alt + Shift + Space` | Pause/Resume tiling |
| `Alt + S` | Save workspace layout |
| `Alt + Shift + S` | Load workspace layout |

### Start / Reload

```powershell
whkd                    # Start daemon
whkd -r                 # Reload config
```

---

## License

This is a personal configuration — feel free to use, modify, and share.
