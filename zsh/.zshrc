# Set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="gallifrey"
# ZSH_THEME="robbyrussell"
# ZSH_THEME="daveverwer"

# powerlevel10k 
# https://github.com/romkatv/powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
if [[ -n "$plugins" ]]; then read -A plugins <<< "$plugins"; else
plugins=(
    aliases
    isodate
    nmap
    rsync
    sudo
    macos
    zsh-autosuggestions
    zsh-syntax-highlighting
)
fi

source $ZSH/oh-my-zsh.sh

# User configuration

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias rm='rm -i'
alias mv='mv -i'
alias view='nvim -R'
alias less='less -FRX'
if type "lsd" > /dev/null ; then
    alias ls="lsd"
fi

alias ll='ls -Flh'
alias lt='ls --tree'

# alias l='clear&&pwd&&ls -FGlh'
alias tree='tree -C'
# alias cat='bat --paging=never'

#export MANPATH="/usr/local/man:$MANPATH"
export MANPAGER='nvim -c "set cmdheight=0" +Man!'

# Remove unused docker images:
alias docker-clean-images='docker images | grep none | awk "{print \$3}" | xargs docker rmi'
alias docker-clean-containers='docker ps -a | grep Exited | awk "{print \$1}" | xargs docker rm'

# PATH to R personal library
#export R_LIBS_USER=$HOME/Library/R/4.x/library

# enable spell check
setopt correct
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color? [Yes, No, Abort, Edit] "

# zsh autosuggest 
# https://github.com/zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=1"
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#e4e4e4"
ZSH_AUTOSUGGEST_STRATEGY=(history)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=(cvs)
ZSH_AUTOSUGGEST_COMPLETION_IGNORE+=('git *', 'cvs *')
# ctrl-space = execute autosuggest
bindkey '^ ' autosuggest-execute

# zsh syntax highlighters
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets pattern cursor)

# pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# if command -v pyenv 1>/dev/null 2>&1; then
   # eval "$(pyenv init -)"
# fi

# Set up fzf key bindings and fuzzy completion
if [[ -d "/opt/local/share/fzf/shell/" ]]  {
    # Mac
    source /opt/local/share/fzf/shell/key-bindings.zsh
    source /opt/local/share/fzf/shell/completion.zsh
} elif [[ -d "/usr/share/doc/fzf/examples" ]]  {
    # Linux
    source /usr/share/doc/fzf/examples/completion.zsh
    source /usr/share/doc/fzf/examples/key-bindings.zsh
}
# fzf shell integration for v >= 0.48.0
# source <(fzf --zsh)

export FZF_DEFAULT_OPTS='--height 50% --border --layout=reverse'
# export FZF_DEFAULT_COMMAND='fd --type f'

# Default editor
export EDITOR=nvim

# Disable python bytecode files
export PYTHONDONTWRITEBYTECODE=1

# eza default parameters
EZA_PARAMS=(--git --group --icons --time-style=long-iso --color-scale=all)
alias eza='eza ${EZA_PARAMS}'

# System dependent PATH
OS="$(uname -s)"
if [[ $OS == "Darwin" ]] {

    # Notes
    notes=/Users/beps/Simularia/Notes
    alias sn='cd $notes; nvim "$(rg --files $notes | fzf)"'

    # Personal bin folders to PATH
    export PATH=~/bin:~/.local/bin:~/Library/Python/3.12/bin:/opt/local/libexec/gnubin:/opt/local/bin:/opt/local/sbin:/opt/gfortran/bin:$PATH

    export MANPATH=/opt/local/share/man:$MANPATH

    # Python pkg-config
    export PKG_CONFIG_PATH=/opt/local/Library/Frameworks/Python.framework/Versions/Current/lib/pkgconfig

    # Configure mac native clang to use macports patshs
    export CPPFLAGS='-isystem/opt/local/include'
    export LDFLAGS='-L/opt/local/lib'

    # kitty specifics
    if [[ $TERM = "xterm-kitty" ]] ; then
        # kitty ssh
        alias s='kitty +kitten ssh'

        # kity dark and light background
        alias kittyDark='kitty +kitten themes --reload-in=all Github\ Dark'
        alias kittyLight='kitty +kitten themes --reload-in=all Github\ Light'
    fi

    # iterm2 specifics
    if [[ $LC_TERMINAL = "iTerm2" ]] ; then
        # iterm2 shell integration
        [ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh
    fi

    # wezterm specifics
    if [[ -v WEZTERM_EXECUTABLE ]] ; then
        # wezterm shell integration
        [[ -f $HOME/.config/wezterm/wezterm.sh ]] && source $HOME/.config/wezterm/wezterm.sh
        # wezterm binary folder
        export PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS/"
    fi

} elif [[ $OS == "Linux" ]] {

    # Compilation flags
    # export ARCHFLAGS="-arch x86_64"

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

    export PATH=$HOME/.local/bin:${HOME}/node_modules/.bin/:/home/exe64:$PATH
    export PATH=/usr/local/cuda-12.1/bin${PATH:+:${PATH}}
} fi

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/powerlevel10k/.p10k.zsh.
[[ ! -f ~/.dotfiles/powerlevel10k/.p10k.zsh ]] || source ~/.dotfiles/powerlevel10k/.p10k.zsh
