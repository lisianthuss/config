FROM ubuntu:latest

RUN apt update -y
RUN apt upgrade -y
RUN apt install -y wget curl git zsh python-dev python3-dev python3-pip neovim unzip fasd
RUN chsh -s /usr/bin/zsh

WORKDIR /root

RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
RUN yes | sh /root/install.sh

RUN git clone https://github.com/lisianthuss/config.git
RUN cp ~/config/.zshrc ~/.zshrc
RUN mkdir -p ~/.config/nvim/
RUN cp ~/config/nvim/init.vim ~/.config/nvim/init.vim
RUN cp -r ~/config/.oh-my-zsh ~/.config/nvim/.oh-my-zsh
RUN cp -r ~/config/nvim/plugged ~/.config/nvim/plugged

RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

RUN wget https://golang.org/dl/go1.17.1.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.17.1.linux-amd64.tar.gz
RUN echo export PATH=$PATH:/usr/local/go/bin >> ~/.zshrc



ENTRYPOINT zsh
