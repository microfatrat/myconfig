# ========================
# Basic Options
# ========================

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS          # Ignore consecutive duplicates
setopt HIST_FIND_NO_DUPS         # Do not display duplicates during search
setopt INC_APPEND_HISTORY_TIME   # Write each command immediately with timestamp
setopt SHARE_HISTORY             # Share history across terminals in real time

setopt AUTO_CD                   # Type directory name to cd into it
setopt AUTO_PUSHD                # Automatically push old directory onto stack when cd'ing
setopt PUSHD_IGNORE_DUPS         # No duplicate directories in stack
setopt EXTENDED_GLOB             # Enable extended globbing (e.g., ^, #)
setopt CORRECT                   # Auto‑correct obvious typos in commands

# ========================
# Completions System
# ========================

autoload -Uz compinit
compinit -C                      # -C skips security checks for faster startup

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zcompcache
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# ========================
# Aliases
# ========================

# Colorized ls depending on OS
if [[ "$OSTYPE" == linux-gnu* ]]; then
  alias ls='ls --color=auto'
elif [[ "$OSTYPE" == darwin* ]]; then
  alias ls='ls -G'
fi

alias ll='ls -alF'               # All files, detailed, with type indicators
alias la='ls -A'                 # All files except . and ..
alias l='ls -CF'                 # Columns, with type suffixes
alias grep='grep --color=auto'  # Highlight matches

# Safe file operations (interactive & verbose)
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -i'
alias mkdir='mkdir -p'

# Navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'                # Go back to previous directory
alias d='dirs -v'                # Show directory stack with indices

# ========================
# Key Bindings
# ========================

bindkey '^[[H' beginning-of-line   # Home key
bindkey '^[[F' end-of-line         # End key
bindkey '^[[3~' delete-char        # Delete key
bindkey '^[[1;5C' forward-word     # Ctrl+Right
bindkey '^[[1;5D' backward-word    # Ctrl+Left
bindkey '^R' history-incremental-search-backward

# ========================
# Prompt
# ========================

PROMPT='%F{cyan}%n@%m%f %F{green}%~%f %F{yellow}%#%f '
RPROMPT='%F{magenta}%T%f'         # Right prompt: time

# ========================
# Plugins (if available)
# ========================

for plugin in zsh-syntax-highlighting zsh-autosuggestions; do
  for prefix in /usr/share/zsh/plugins /usr/local/share /usr/share; do
    if [[ -f "$prefix/$plugin/$plugin.zsh" ]]; then
      source "$prefix/$plugin/$plugin.zsh"
      break
    fi
  done
done
