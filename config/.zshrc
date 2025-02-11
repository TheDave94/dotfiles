# -- Set the directory we want to store zinit and plugins

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# -- Download Zinit, if it's not there yet

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# -- Source/Load zinit

source "${ZINIT_HOME}/zinit.zsh"

# -- Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# -- Add in snippets

zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::archlinux
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# -- Environment Variables

export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="ghostty"
export TERM="xterm-256color"
export BROWSER="brave-beta"

# -- Path

setopt extended_glob null_glob

path=(
  $path
  $HOME/bin
  $HOME/.local/bin
  $HOME/go
)

typeset -U path
path=($^path(N-/))

export PATH

# -- History

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_space
setopt hist_reduce_blanks
setopt share_history
setopt hist_save_no_dups

# -- Aliases

alias ls="eza -al --color=always --group-directories-first --icons --git"
alias nv="nvim"
alias c="clear"
alias ff="fastfetch"
alias dotfiles="cd ~/.config/dotfiles/"

alias cat="bat"
alias catnn="bat --style=numbers"
alias catn="bat --style=numbers,changes"

alias install="sudo pacman -S --needed --noconfirm"
alias update="yay -Syuu --noconfirm && yay -Scc --noconfirm && yay -Yc --noconfirm"
alias remove="sudo pacman -Rncs --noconfirm"
alias unlock="sudo rm /var/lib/pacman/db.lck"
alias clean="cd /var/cache/pacman/pkg && sudo rm -rf * && cd"

alias y="yay -S --needed --noconfirm"
alias yr="yay -Rncs --noconfirm"

alias gp="git pull"
alias gs="git status"
alias gc="gh repo clone"
alias repo="cd ~/repos/"
alias builds="cd ~/builds/"
alias repos="cd ~/Repos/"
alias dot="cd ~/.config/dotfiles/"

# -- Sourcing

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux new-session -A -s default
fi

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

autoload -Uz compinit && compinit
zinit cdreplay -q

# -- FZF-TAB

setopt GLOB_DOTS

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# -- Starship

eval "$(starship init zsh)"
