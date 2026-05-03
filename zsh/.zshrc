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

# PreLineDisplay  (3 powerline segments, light→medium→dark turquoise)
autoload -U colors && colors
setopt PROMPT_SUBST

precmd() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  if [[ -n $branch ]]; then
    PS1='%K{116}%F{black} %n@%m %F{116}%K{73}%F{black} %2~ %F{73}%K{30}%F{white}  '"$branch"' %F{30}%k%f
%(?.%F{green}$>.%F{red}$>)%f '
  else
    PS1='%K{116}%F{black} %n@%m %F{116}%K{73}%F{black} %2~ %F{73}%k%f
%(?.%F{green}$>.%F{red}$>)%f '
  fi
}

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
alias lg="lazygit"

# Env variables
export EDITOR="nvim"
export PATH="$HOME/.local/bin:$PATH"
export MANPAGER='nvim +Man!'
export PAGER="nvim"
export DIFFPROG="nvim -d"
