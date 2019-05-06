#! /bin/sh

echo \*

umask 22

test -r .rhosts && echo yikes! rhosts!

stty erase 
stty kill 
stty intr 
stty susp 

case "$TERM" in
    xterm-256color|screen-256color|xterm-color)
        TERMINFO=$HOME/.terminfo
        stty erase 
        export TERMINFO
    ;;
esac

if [ ! -f $HOME/NOZSH ]; then
    PATH="$HOME/`uname -s`-`uname -p 2>/dev/null || uname -m`/bin:$PATH"
    type zsh >/dev/null 2>&1 && exec zsh
fi
