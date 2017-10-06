FROM thesheff17/docker_go_source

MAINTAINER Dan Sheffner <Dan@Sheffner.com>

# vim modules
RUN mkdir -p /root/.vim/autoload /root/.vim/bundle /root/.vim/colors/ /root/.vim/ftplugin/
RUN curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
WORKDIR /root/.vim/bundle/
RUN git clone https://github.com/tpope/vim-sensible.git
RUN git clone https://github.com/ctrlpvim/ctrlp.vim.git

# project died
# RUN git clone https://github.com/kien/ctrlp.vim.git
RUN git clone https://github.com/scrooloose/nerdtree
RUN git clone https://github.com/Lokaltog/vim-powerline.git
RUN git clone https://github.com/jistr/vim-nerdtree-tabs.git
RUN git clone https://github.com/python-mode/python-mode.git
# RUN git clone --recursive https://github.com/davidhalter/jedi-vim.git
RUN git clone https://github.com/fatih/vim-go.git
RUN git clone https://github.com/vim-syntastic/syntastic.git

WORKDIR /root/.vim/colors/
RUN wget https://raw.githubusercontent.com/thesheff17/youtube/master/vim/wombat256mod.vim
WORKDIR /root/.vim/ftplugin/
RUN wget https://raw.githubusercontent.com/thesheff17/youtube/master/vim/python_editing.vim
WORKDIR /root/
RUN wget https://raw.githubusercontent.com/thesheff17/youtube/master/vim/vimrc2
RUN mv vimrc2 .vimrc

# go packages
RUN export PATH=$PATH:/usr/local/go/bin && \
    export GOPATH=/root/go/bin && \
    export GOBIN=/root/go/bin && \
    go get github.com/nsf/gocode && \
    go get github.com/alecthomas/gometalinter && \
    go get golang.org/x/tools/cmd/goimports && \
    go get golang.org/x/tools/cmd/guru && \
    go get golang.org/x/tools/cmd/gorename && \
    go get github.com/golang/lint/golint && \
    go get github.com/rogpeppe/godef && \
    go get github.com/kisielk/errcheck && \
    go get github.com/jstemmer/gotags && \
    go get github.com/klauspost/asmfmt/cmd/asmfmt && \
    go get github.com/fatih/motion && \
    go get github.com/zmb3/gogetdoc && \
    go get github.com/josharian/impl

CMD ["/bin/bash"]
