FROM ubuntu:latest

RUN apt update -y
RUN apt upgrade -y

RUN apt install -y wget curl git zsh python-dev python3-dev python3-pip neovim unzip fasd #nodejs

#RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

WORKDIR /root

#RUN git clone https://github.com/lisianthuss/config.git
#RUN cp ~/config/.zshrc ~/.zshrc
#RUN mkdir -p ~/.config/nvim/
#RUN cp ~/config/nvim/init.vim ~/.config/nvim/init.vim
#RUN cp -r ~/config/nvim/plugged ~/.config/nvim/plugged

RUN wget https://golang.org/dl/go1.17.1.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.17.1.linux-amd64.tar.gz
RUN echo export PATH=$PATH:/usr/local/go/bin >> ~/.zshrc

ENTRYPOINT zsh
