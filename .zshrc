PS1='%F{blue}󰊠 %n%f %F{red}%~%f ' 
#RPROMPT='%F{red}%~ %f'
#(cat ~/.cache/wal/sequences &)
#/usr/local/bin/fetch
#echo ""

#############
### Zinit ###
#############

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
autoload -U compinit && compinit

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
zstyle ':completion:*' menu no
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:cat:*' fzf --preview 'fzf-preview {}'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

###########
### ZSH ###
###########

HISTSIZE=5000
HISTFILE=~/.zhistory
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

################
### Keybinds ###
################

bindkey -e

bindkey '^n' history-search-forward
bindkey '^p' history-search-backward

#################
### Functions ###
#################

function yazy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

figlett() {
  local output
  output=$(printf '```\n%s\n```\n' "$(figlet "$@")")
  echo "$output"
  echo "$output" | wl-copy
  echo "Copied to clipboard!"
}

############
### Java ###
############

export ANDROID_HOME="$HOME/.android-sdk"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools"

#############
### Extra ###
#############

alias ls='ls --color'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias vi='vim'
alias f='clear && fetch'
alias ytm='yt-dlp -x --audio-format opus --audio-quality 0 --embed-thumbnail --add-metadata -o "~/Music/download/%(title)s.%(ext)s"'
