# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="gallifrey"
# ZSH_THEME="robbyrussell"
ZSH_THEME="daveverwer"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=7

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

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
if [[ -n "$plugins" ]]; then read -A plugins <<< "$plugins"; else
plugins=(
    aliases
    colored-man-pages
    isodate
    nmap
    rsync
    sudo
    macos
    zsh-autosuggestions
    # zsh-syntax-highlighting
)
fi

source $ZSH/oh-my-zsh.sh

# User configuration

# Get OS
OS="$(uname -s)"


export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias rm='rm -i'
alias mv='mv -i'
alias vim='nvim'
alias view='nvim -R'
alias vi='nvim'
alias less='less -FRX'
if type "lsd" > /dev/null ; then
    alias ls="lsd"
fi

alias ll='ls -Flh'
alias lt='ls --tree'

# alias l='clear&&pwd&&ls -FGlh'
alias tree='tree -C'
# alias cat='bat --paging=never'


# Remove unused docker images:
alias docker-clean-images='docker images | grep none | awk "{print \$3}" | xargs docker rmi'
alias docker-clean-containers='docker ps -a | grep Exited | awk "{print \$1}" | xargs docker rm'



# System dependent PATH
if [[ $OS == "Darwin" ]] {
    # kitty ssh
    alias s='kitty +kitten ssh'

    # Personal bin
    export PATH=~/bin:~/.local/bin:~/.cargo/bin:$PATH
    export PATH=/usr/local/sbin:$PATH
    export PATH=$PATH:/usr/local/gfortran/bin

    # Homebrew
    export HOMEBREW_NO_ANALYTICS=1
    # export HOMEBREW_INSTALL_FROM_API=1 

    # broot
    source /Users/beps/.config/broot/launcher/bash/br

} elif [[ $OS == "Linux" ]] {
    export PATH=$HOME/bin:$HOME/.local/bin:${HOME}/node_modules/.bin/:/home/exe64:$PATH
} fi

# export PATH="/usr/local/opt/gdal2-python/bin:$PATH"
# export GDAL_DRIVER_PATH=/usr/local/lib/gdalplugins
# export LDFLAGS="-L/usr/local/opt/gdal2/lib"
# export CPPFLAGS="-I/usr/local/opt/gdal2/include"
# export PKG_CONFIG_PATH="/usr/local/opt/gdal2/lib/pkgconfig"

# export LD_LIBRARY_PATH="/usr/local/lib"
# export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig"
# 
# export PATH=$PKG_CONFIG_PATH:$PATH

# PATH to R personal library
#export R_LIBS_USER=$HOME/Library/R/4.x/library


# Add hostname to prompt
# PROMPT="%{$fg[green]%}%m%{$reset_color%} ${PROMPT}"

# enable spell check
setopt correct
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color? [Yes, No, Abort, Edit] "

# zsh autosuggest (see https://github.com/zsh-users/zsh-autosuggestions)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=1"
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#e4e4e4"
ZSH_AUTOSUGGEST_STRATEGY=(history)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=(cvs)
ZSH_AUTOSUGGEST_COMPLETION_IGNORE+=('git *', 'cvs *')
# ctrl-space = execute autosuggest
bindkey '^ ' autosuggest-execute

# Ruby
# export PATH="/usr/local/opt/ruby/bin:$PATH"
# export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"

# pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# if command -v pyenv 1>/dev/null 2>&1; then
   # eval "$(pyenv init -)"
# fi

# bat
# export BAT_THEME=GitHub

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border --inline-info'
export FZF_DEFAULT_COMMAND='fd --type f'

# Default editor
export EDITOR=vim

# Disable python bytecode files
export PYTHONDONTWRITEBYTECODE=1


if [[ $OS == "Linux" ]] ; then
    # FZF
    source /usr/share/doc/fzf/examples/completion.zsh
    source /usr/share/doc/fzf/examples/key-bindings.zsh

    # Compilation flags
    # export ARCHFLAGS="-arch x86_64"

    #
    # # Code Saturne
    # export cspath=/home/carlino/Code_Saturne/6.1.0/code_saturne-6.1.0/arch/Linux_x86_64/bin
    # alias code_saturne="$cspath/code_saturne"

    # nvidia HPC SDK environmental setup
    # export NVARCH=`uname -s`_`uname -m`
    # export NVCOMPILERS=/opt/nvidia/hpc_sdk
    # export MANPATH=$MANPATH:$NVCOMPILERS/$NVARCH/22.5/compilers/man
    # export PATH=$NVCOMPILERS/$NVARCH/22.5/compilers/bin:$PATH

    # export LD_LIBRARY_PATH=/usr/local/cuda-11.5/lib64\
    #     ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

    # alias luamake=/home/carlino/lua-language-server/3rd/luamake/luamake

    if [ -d /etc/profile.d ]; then
        setopt no_nomatch
        for i in /etc/profile.d/*.sh; do
            if [ -r $i ]; then
                . $i
            fi
        done
        setopt nomatch
    fi

    # module load nvhpc/22.5
    
    # Permanently change umask
    umask 002

fi


