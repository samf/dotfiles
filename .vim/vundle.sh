#! /bin/sh -xe

test -d Vundle.vim || {
    cat <<EOF
    You need to install python3-venv either by
    sudo apt install python3-venv
    or
    brew install python3 && pip3 install virtualenv
    You must do this before you run VundleUpdate!
EOF
    git clone https://github.com/VundleVim/Vundle.vim.git \
        $HOME/.vim/bundle/Vundle.vim
}
