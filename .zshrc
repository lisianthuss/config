# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh && zplug update
fi

if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ ! -d ~/.local/share/nvim/site/autoload ]; then
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

if [ ! -d ~/.config/lisianthuss ]; then
    git clone https://github.com/lisianthuss/config.git ~/.config/lisianthuss
    cp ~/.config/lisianthuss/.zshrc ~/.zshrc
    mkdir -p ~/.config/nvim/
    cp ~/.config/lisianthuss/nvim/init.vim ~/.config/nvim/init.vim
    cp -r ~/.config/lisianthuss/nvim/plugged ~/.config/nvim/plugged
fi

export GOPATH=$HOME/.go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH=$HOME/.pyenv/bin:$PATH
export PIPENV_VENV_IN_PROJECT=1
export XDG_CONFIG_PATH=$HOME/.config
export PATH="/usr/local/opt/go@1.16/bin:$PATH"

source ~/.zplug/init.zsh

ZSH_THEME="powerlevel10k/powerlevel10k"

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
zplug 'zsh-users/zsh-syntax-highlighting'
zplug 'zsh-users/zsh-history-substring-search'
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug 'webyneter/docker-aliases', use:docker-aliases.plugin.zsh 
zplug 'wookayin/fzf-fasd'
zplug 'hschne/fzf-git'
zplug 'Aloxaf/fzf-tab'
zplug 'akarzim/zsh-docker-aliases'


if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

export ZSH="/Users/lisian/.oh-my-zsh"

plugins=(
    git
    fzf
    zsh-syntax-highlighting
    zsh-history-substring-search
    zsh-autosuggestions
    zsh-completions
)

source $ZSH/oh-my-zsh.sh


alias di="docker images"
alias dnw="docker networks ls"
alias dcu="docker-compose up -d"
alias dcd="docker-compose down"
alias dcps="docker-compose ps"
alias dcl="docker-compose logs"
alias dcr="docker-compose restart"

alias dps="docker ps"
alias dpa="docker ps -a"

alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
alias drm='docker rm $(docker ps -a -q)'
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/" | sed "s/['|\']//g" | sort; }

alias v="nvim"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
