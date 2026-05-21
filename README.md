# MyConfig

Personal Zsh configuration — a clean, portable `.zshrc` that works across Linux and macOS.

## Quick Start

```bash
git clone git@github.com:microfatrat/myconfig.git ~/myconfig
ln -sf ~/myconfig/.zshrc ~/.zshrc
```

Or with GNU stow:

```bash
stow -t ~ -d ~/myconfig .
```

## What's Inside

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

## Requirements

- Zsh 5.0+
- For plugins: install via your package manager (e.g., `apt install zsh-syntax-highlighting zsh-autosuggestions`)

## License

This is a personal configuration — feel free to use, modify, and share.
