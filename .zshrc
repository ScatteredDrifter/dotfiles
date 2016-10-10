# Use advanced prompt support
#autoload -U promptinit && promptinit

# My promt
PS1=$'%{\e[0;34m%}%n %{\e[0m%}at %{\e[0;33m%}%M %{\e[0m%}in %{\e[1;35m%}%~ 
%{\e[0m%}>> '

# Use modern completion system
autoload -U compinit && compinit

# Use colors
autoload -U colors && colors
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# Load in additional files
source "$HOME/.zsh/alias"
source "$HOME/.zsh/keys"
source "$HOME/.zsh/functions"
source "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
source "$HOME/.zsh/plugins/h.sh"
source "$HOME/.zsh/plugins/t-completion.zsh"

# Exports
export SHELL="/bin/zsh"
export EDITOR="vim"
export BROWSER="qutebrowser"
export LC_ALL=en_US.UTF-8
export LC_TIME=sv_SE.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export ZLS_COLORS=$LS_COLORS
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$HOME/.bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export PATH="$HOME/Scripts:$PATH"
export FREETYPE_PROPERTIES="truetype:interpreter-version=35"

# zsh-completions
fpath=($HOME/Git/zsh-completions/src $fpath)
fpath=($HOME/.zsh/completions/ $fpath)

# History
HISTFILE=~/.zsh/history
HISTSIZE=250000
SAVEHIST=100000

# No history if command starts with space
setopt histignorespace

# History Vi-like search 
bindkey -M vicmd k history-search-backward
bindkey -M vicmd j history-search-forward
bindkey -M vicmd / history-incremental-search-backward
bindkey -M vicmd n history-incremental-search-backward
bindkey -M vicmd N history-incremental-search-forward

# LS_COLORS
eval $(dircolors -b $HOME/.zsh/plugins/ls_colors)

# Respect multibyte characters when found in strings
unsetopt MULTIBYTE

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

#keychain
eval $(keychain --eval --noask --nogui --quiet --agents ssh id_rsa_fjuppen)

# Quote pasted URLs
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# Home and End keys
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line 

# Group symlinks with folders first using ls
# ls -ldU -- *(o+dir1st)
dir1st() { [[ -d $REPLY ]] && REPLY=1-$REPLY || REPLY=2-$REPLY;}

# Edit command line with $EDITOR
autoload -U edit-command-line
# Emacs style
zle -N edit-command-line
#bindkey '^xe' edit-command-line
#bindkey '^x^e' edit-command-line
# Vi style:
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Enable Vi mode for zsh
bindkey -v
# no delay entering normal mode
# https://coderwall.com/p/h63etq
# https://github.com/pda/dotzsh/blob/master/keyboard.zsh#L10
# 10ms for key sequences
KEYTIMEOUT=1
# show vim status
# http://zshwiki.org/home/examples/zlewidgets
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
# add missing vim hotkeys
# http://zshwiki.org/home/zle/vi-mode
bindkey -a u undo
bindkey -a '^T' redo
bindkey '^?' backward-delete-char  #backspace
# history search in vim mode
# http://zshwiki.org./home/zle/bindkeys#why_isn_t_control-r_working_anymore
# ctrl+r to search history
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

# Ruby PATH
if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi
