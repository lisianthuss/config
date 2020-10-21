if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update
fi

source ~/.zplug/init.zsh

ZSH_THEME="mlh"

# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins-Overview
zplug 'plugins/docker', from:oh-my-zsh
zplug 'plugins/git', from:oh-my-zsh
zplug 'plugins/colored-man-pages', from:oh-my-zsh
zplug 'plugins/colorized', from:oh-my-zsh
zplug 'plugins/command-not-found', from:oh-my-zsh
zplug 'plugins/cp', from:oh-my-zsh
zplug 'plugins/dircycle', from:oh-my-zsh
zplug 'plugins/docker-ompose', from:oh-my-zsh
zplug 'plugins/tmux', from:oh-my-zsh
zplug 'plugins/tmuxinator', from:oh-my-zsh
zplug 'plugins/fzf', from:oh-my-zsh
zplug 'plugins/fasd', from:oh-my-zsh
zplug 'wting/autojump'
zplug 'zsh-users/zsh-syntax-highlighting'
zplug 'zsh-users/zsh-history-substring-search'
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug 'webyneter/docker-aliases', use:docker-aliases.plugin.zsh 
zplug 'wookayin/fzf-fasd'
zplug 'hschne/fzf-git'
zplug 'Aloxaf/fzf-tab'


if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

export ZSH="~/.oh-my-zsh"
export PATH=/opt/swift/usr/bin:$PATH

plugins=(git)

source $ZSH/oh-my-zsh.sh


alias di="docker images"
alias dnw="docker networks ls"
alias dcu="docker-compose up -d"
alias dcp="docker-compose ps"
alias dcl="docker-compose logs"
alias dcr="docker-compose restart"

alias dps="docker ps"
alias dpa="docker ps -a"

alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
alias drm='docker rm $(docker ps -a -q)'
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/" | sed "s/['|\']//g" | sort; }

alias v="nvim"
