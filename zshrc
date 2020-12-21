#zmodload zsh/zprof # for debugging
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="pygmalion"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
if [ "$(uname)" '==' "Darwin" ]; then
    plugins=(brew django git npm pip python screen sublime sudo jump virtualenv-prompt zsh-syntax-highlighting)
else
    plugins=(django git npm pip python screen sudo jump virtualenv-prompt zsh-syntax-highlighting)
fi
# User configuration

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/texbin"

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LC_ALL=en_DK.utf8 && export LANG=en_DK.utf8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi


if [ "$(uname)" '==' "Darwin" ]; then

    # dircolors
    eval `gdircolors ~/.scripts/.dir_colors`
    alias ls='gls --color'

    #GNU-sed on os x
    export PATH="$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$PATH"
    export MANPATH="$(brew --prefix)/opt/gnu-sed/libexec/gnuman:$MANPATH"

    # go path
    export PATH=$PATH:/usr/local/opt/go/libexec/bin
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH/bin

    export LC_CTYPE="UTF-8"

    # scripts that should be i path
    export PATH=$HOME/dotfiles/scripts/path:$PATH


    # concatenate ssh config files
    #cat ~/.ssh/configs/*.config > ~/.ssh/config
fi

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit


# source scripts in dotfiles
for file in ~/.scripts/source/*; do
    source $file
done

# source autoenv
source /usr/local/bin/activate.sh
#zprof # for debugging
