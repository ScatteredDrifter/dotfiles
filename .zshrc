autoload -U promptinit && promptinit
autoload -U colors && colors
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit

# My promt
PS1=$'%{\e[0;34m%}%n %{\e[0m%}at %{\e[0;33m%}%M %{\e[0m%}in %{\e[1;35m%}%~ 
%{\e[0m%}>> '

# Load in additional files
source "$HOME/.zsh/alias"
source "$HOME/.zsh/keys"
source "$HOME/.zsh/functions"
source "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
source "$HOME/.zsh/plugins/h.sh"
source "$HOME/.zsh/plugins/t-completion.zsh"
source "$HOME/.zsh/plugins/vi-mode.zsh"

# Exports
export SHELL="/bin/zsh"
export EDITOR="vim"
export BROWSER="palemoon"
export LC_ALL=en_US.UTF-8
export LC_TIME=sv_SE.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export ZLS_COLORS=$LS_COLORS
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="${PATH}:/home/johan/bin"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export PATH="$HOME/Scripts:$PATH"

# Ruby PATH
if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# zsh-completions
fpath=($HOME/Git/zsh-completions/src $fpath)

# History
HISTFILE=~/.zsh/history
HISTSIZE=250000
SAVEHIST=100000

# No history if command starts with space
setopt histignorespace

# LS_COLORS
eval $(dircolors -b $HOME/.zsh/plugins/ls_colors)

# Respect multibyte characters when found in strings
unsetopt MULTIBYTE

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2 eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*' menu select 

# ssh-agent
#envoy -t ssh-agent -a ~/.ssh/id_ed25519_fjuppen
#source <(envoy -p)

#keychain
eval $(keychain --eval --noask --quiet ~/.ssh/id_ed25519_fjuppen)

# Quote pasted URLs
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

