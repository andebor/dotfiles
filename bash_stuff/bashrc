# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.scripts/.dircolors && eval "$(dircolors -b ~/.scripts/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -la'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions in seperate file.
if [ -f ~/.scripts/.bash_aliases ]; then
    . ~/.scripts/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#Macports
# export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=/opt/local/libexec/gnubin:/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH

# Terminal colours (after installing GNU coreutils)
NM="\[\033[0;38m\]" #means no background and white lines
HI="\[\033[0;32m\]" #change this for letter colors
HII="\[\033[0;31m\]" #change this for letter colors
SI="\[\033[0;33m\]" #this is for the current directory
IN="\[\033[0m\]"

# Decide color for hostname
if [ "$HOSTNAME" = "Anders.local" ]; then
		HII="\[\033[0;36m\]"
fi
if [ "$HOSTNAME" = "rocky" ]; then
    HII="\[\033[0;31m\]"
fi
if [ "$HOSTNAME" = "rambo" ]; then
	  HII="\[\033[0;35m\]"
fi
if [ "$HOSTNAME" = "macgyver" ]; then
    HII="\[\033[0;34m\]"
fi

# Git prompt
parse_git_branch() {
	            git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
		              }

# Translates to [ *username* *machinename* /*Path*/ ]
export PS1="$NM[ $HI\u $HII\h $SI\w$NM\$(parse_git_branch)] $IN"

if [ "$TERM" != "dumb" ]; then
		export LS_OPTIONS='--color=auto'
	  eval `dircolors ~/.scripts/.dir_colors`
fi

# Useful aliases
alias ls='ls $LS_OPTIONS -hF'
alias ll='ls $LS_OPTIONS -lahF'
alias l='ls $LS_OPTIONS -lAhF'
alias cd..="cd .."
alias c="clear"
alias e="exit"
alias ssh="ssh -X"
alias ..="cd .."

#Virtualenv
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then #check if virtualenvwrapper is installed
		export WORKON_HOME=$HOME/.virtualenvs
		source /usr/local/bin/virtualenvwrapper.sh
fi

#Git-completion
source ~/.scripts/.git-completion.bash

#Virtualbox-completion
if [ "$(uname)" == "Linux" ]; then #check if linux
	if [ -f /usr/bin/virtualbox ]; then #check if virtualbox installed
		source ~/.scripts/.virtualbox-completion.bash
	fi
fi

#Locales
export LC_ALL=en_DK.utf8 && export LANG=en_DK.utf8
export PATH="/usr/local/bin:$PATH"

# TextEditor
export EDITOR='vim'

## JUMP ##

export MARKPATH=$HOME/.marks
function jump { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
		mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
		rm -i "$MARKPATH/$1"
}
if [ "$(uname)" == "Linux" ]; then #if linux
		function marks {
				ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
		}
elif [ "$(uname)" == "Darwin" ]; then #if mac
		function marks {
					\ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
		}
fi

# Jump - autocomplete 
_completemarks() {
	local curw=${COMP_WORDS[COMP_CWORD]}
	local wordlist=$(find $MARKPATH -type l -printf "%f\n") #reguire findutils on mac
	COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
	return 0
}

complete -F _completemarks jump unmark

### check for changes to remote bashrc repo (NOT COMPLETE)
# source ~/.scripts/checkGit.bash

export TERM=xterm-256color