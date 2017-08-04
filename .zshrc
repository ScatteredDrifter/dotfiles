#------------------------------------------------------------------#
# Completions
#------------------------------------------------------------------#

# Pacman
zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

# Colors
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

# For autocompletion with an arrow-key driven interface
zstyle ':completion:*' menu select

# Autocompletion of command line switches for aliases
#setopt complete_aliases # Brakes completion for aliases like ps (pacman -S)

# zsh-completions
fpath=($HOME/Git/zsh-completions/src $fpath)
fpath=($HOME/.zsh/completions/ $fpath)

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Organize completions by categories
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*' format $'\n%F{yellow}Completing %d%f\n'
zstyle ':completion:*' group-name ''

# Respect multibyte characters when found in strings
unsetopt MULTIBYTE

# Quote pasted URLs
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# When new programs is installed, auto update autocomplete without reloading shell
zstyle ':completion:*' rehash true

# Don't prompt for a huge list, page it!
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# No need for 'cd'
setopt autocd

# Group symlinks with folders first using ls
# ls -ldU -- *(o+dir1st)
dir1st() { [[ -d $REPLY ]] && REPLY=1-$REPLY || REPLY=2-$REPLY;}

# Edit command line with $EDITOR
autoload -U edit-command-line

# Copy current command to clipboard (Ctrl+X)
zle -N copyx; copyx() { echo -E $BUFFER | xsel -ib }; bindkey '^X' copyx

#------------------------------------------------------------------#
# Load in additional files
#------------------------------------------------------------------#
source "$HOME/.zsh/alias"
source "$HOME/.zsh/functions"
source "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
source "$HOME/.zsh/plugins/h.sh"
source "$HOME/.zsh/plugins/t-completion.zsh"
source "/etc/profile.d/autojump.sh"

#------------------------------------------------------------------#
# Variables
#------------------------------------------------------------------#
export SHELL="/bin/zsh"
export TERMINAL="rxvt-256color"
export EDITOR="vim"
export BROWSER="qutebrowser"
export LC_ALL=en_US.UTF-8
export LC_TIME=sv_SE.UTF-8
export LANG=en_US.UTF-8
#export LANGUAGE=en_US.UTF-8
#export ZLS_COLORS=$LS_COLORS
#export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$HOME/Scripts/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Scripts:$PATH"
export PATH="$HOME/.gem/ruby/2.4.0/bin:$PATH"
export FREETYPE_PROPERTIES="truetype:interpreter-version=35"
export GEM_HOME="$(ruby -e 'print Gem.user_dir')"

#------------------------------------------------------------------#
# History
#------------------------------------------------------------------#
HISTFILE=~/.zsh/history
HISTSIZE=1000
SAVEHIST=1000

# Ignore duplicate history
setopt hist_ignore_all_dups
setopt hist_save_no_dups

# No history if command starts with space
setopt histignorespace

# History search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

# Better history behavior (acts the same as vim)
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "\e[A" history-beginning-search-backward-end
bindkey "\e[B" history-beginning-search-forward-end

# History Vi-like search 
bindkey -M vicmd l history-search-backward
bindkey -M vicmd k history-search-forward
bindkey -M vicmd / history-incremental-search-backward
bindkey -M vicmd n history-incremental-search-backward
bindkey -M vicmd N history-incremental-search-forward
bindkey -M vicmd l history-beginning-search-backward
bindkey -M vicmd k history-beginning-search-forward

#------------------------------------------------------------------#
# Promt 
#------------------------------------------------------------------#
# Prompt themes
#autoload -Uz promptinit
#promptinit

# My promt
PS1=$'%{\e[0;34m%}%n %{\e[0m%}at %{\e[0;33m%}%M %{\e[0m%}in %{\e[1;35m%}%~ 
%{\e[0m%}>> '

#------------------------------------------------------------------#
# Colors
#------------------------------------------------------------------#
# Use colors
autoload -U colors && colors

# Dircolors
#eval $(dircolors -b $HOME/.zsh/dircolors/trapd00r)
eval $(dircolors -b $HOME/.zsh/dircolors/solarized)

#------------------------------------------------------------------#
# Keychain
#------------------------------------------------------------------#
eval $(keychain --eval --noask --nogui --quiet --agents ssh id_rsa_fjuppen)

#------------------------------------------------------------------#
# Vi mode
#------------------------------------------------------------------#
zle -N edit-command-line
bindkey -M vicmd '^V' edit-command-line
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

# Functional home/end/delete/insert keys
bindkey '\e[1~'   beginning-of-line  # Linux console
bindkey '\e[H'    beginning-of-line  # xterm
bindkey '\eOH'    beginning-of-line  # gnome-terminal
bindkey '\e[2~'   overwrite-mode     # Linux console, xterm, gnome-terminal
bindkey '\e[3~'   delete-char        # Linux console, xterm, gnome-terminal
bindkey '\e[4~'   end-of-line        # Linux console
bindkey '\e[F'    end-of-line        # xterm
bindkey '\eOF'    end-of-line        # gnome-terminal

#------------------------------------------------------------------#
# Git
#------------------------------------------------------------------#
autoload -Uz vcs_info # Needed for dynamic windows titles

#------------------------------------------------------------------#
# Dynamic window title
#------------------------------------------------------------------#
case $TERM in
  termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
    precmd () {
      vcs_info
      print -Pn "\e]0;%n at %M in %~\a"
    } 
#    preexec () { print -Pn "\e]0;%n at %M in %~ >> $1\a" }
    preexec () { print -Pn "\e]0;$1\a" }
    ;;
  screen|screen-256color)
    precmd () { 
      vcs_info
      print -Pn "\e]83;title \"$1\"\a" 
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a" 
    }
    preexec () { 
      print -Pn "\e]83;title \"$1\"\a" 
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a" 
    }
    ;; 
esac

#------------------------------------------------------------------#
# Fixes
#------------------------------------------------------------------#
# Prevent Screen from freezing when using Ctrl-S/Q in rTorrent
stty ixany
stty ixoff -ixon

# Command completion
# This part needs to be last for the t completion to work
autoload -Uz compinit
compinit

# vim: set ts=2 sw=2 et:
