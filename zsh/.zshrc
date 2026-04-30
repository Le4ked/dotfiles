# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
# vi movement with short esc-timeout
bindkey -v
export KEYTIMEOUT=5

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/alex/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# PreLineDisplay
autoload -U colors && colors
PS1='%F{magenta}%n@%m%f %F{cyan}%~%f %(?.%F{green}$>.%F{red}$>)%f '

# Zellij hook
eval "$(zellij setup --generate-auto-start zsh)"

# yazi shell wrapper
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Alias
alias ls="exa -a --icons --color"
alias lt="exa -T"
alias sysspec="{ inxi -Fxxx -c 0; echo; pacman -Q; } | wl-copy"
alias gitlog="git log --oneline --graph --all"
alias rate-mirrors="rate-mirrors arch | sudo tee /etc/pacman.d/mirrorlist"

# Env variables
export EDITOR="nvim"
export PATH="$HOME/.local/bin:$PATH"
export MANPAGER='nvim +Man!'
export PAGER="nvim"
export DIFFPROG="nvim -d"
