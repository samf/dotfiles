#! /bin/zsh

# zsh options

bindkey -e

setopt auto_cd auto_name_dirs auto_pushd auto_resume pushd_ignore_dups
setopt dvorak hist_ignore_dups hist_ignore_space hist_no_store noclobber
setopt hist_allow_clobber short_loops nobeep cdable_vars interactive_comments
setopt no_nomatch glob_assign print_exit_value

REPORTTIME=1

# zsh variables

wsname=${WS:t}
PROMPT="%B${wsname:-%m}/%!/%(#.#.*)%b "
RPROMPT="%B%~ %T%b"
TMOUT=120

# environment variables

setopt all_export

HISTSIZE=16384
PAGER=less
P4CONFIG=.p4rc
Muser=samf
LESS=is
EDITOR=vi
whirly=/net/whirlpool.us.oracle.com/tank/ws/samf
ONBLD_BUGDB_URL=http://tharunka.us.oracle.com:24601

tzwant=/usr/share/zoneinfo/US/Mountain
[[ -r $tzwant ]] && TZ=$tzwant

unset ENV tzwant

# paths

prepath=(
    $HOME/$(uname -n)/bin
    $HOME/$(uname -s)-$(uname -p 2>/dev/null || uname -m)/bin
    $HOME/$(uname -s)/bin
    $HOME/src/gocode/bin
    /opt/onbld/bin
    /opt/onbld/bin/$(uname -p 2>/dev/null)
    /opt/SUNWspro/ParallelMake/bin
    /opt/SUNWspro/bin
    $HOME/.cargo/bin
)
postpath=(
    /usr/misc/bin
    /usr/local/go/bin
    /usr/local/bin
    /usr/local/sbin
    /ws/opg-lab-tools
    /opt/SUNWstc-stf/bin/$(uname -p)
    /opt/SUNWstc-genutils/bin

    /opt/csw/bin
    /usr/sfw/bin
    /usr/sfw/sbin
    /opt/sfw/bin
    /opt/sfw/sbin
    /opt/local/bin
    /usr/pkg/bin
    /opt/etext/bin
    /usr/X386/bin
    /usr/X11R6/bin
    /usr/bin
    /bin
    /sbin
    /usr/sbin
    /opt/gnome-1.4/bin
    /opt/solarisstudio12.4/bin # should supercede /ws
    /ws/on12-tools/SUNWspro/sunstudio12.4/bin # should supercede tw
    /usr/lib/ak/tools
    /ws/on12-tools/parfait/latest/bin
    /Applications/Postgres.app/Contents/Versions/latest/bin
    /opt/teamware/bin
    /opt/SunStudioExpress/bin
    /usr/dt/bin
    /usr/opt/SUNWmd/sbin
    /opt/SUNWut/bin
    /opt/SUNWut/sbin
    /opt/SUNWut/lib
)
for i in $prepath; path=(${path:#$i})
for i in $prepath $path; postpath=(${postpath:#$i})
path=($prepath $path $postpath)
for i in $path; test -d $i || path=(${path:#$i})
unset prepath postpath

if (( $+commands[vim] )); then
    EDITOR=vim
fi

NODE_PATH=$HOME/$(uname -s)/node_libraries

typeset -gxTU GOPATH gopath

gopath=(
    ~/src/gocode
)

# aliases

alias lf='ls -F'
alias lfa='lf -a'
alias lfs='lfa -s'
alias ll='ls -lisa'

if (( $+commands[exa] )); then
    alias lf='exa -F'
    alias lfa='exa -Fa --all'
    alias ll='exa -Sailh@ --git --all'
fi

alias l=less
alias j=jobs
alias k=kill
alias kk=kubectl
alias z=suspend
alias d='dirs -pv'
alias ds='dirs -pv | sort -k 2'
alias h=history
alias m=make
alias tf='tail -f'
alias ta='type -a'
alias ma=xmodmap
alias dfh='df -h'
alias pyc='python -m py_compile'

if (( ! $+commands[reset] )); then
    alias reset='echo -e "\033c"'
fi

alias -s go=vim
alias -s {yml,yaml}=vim
alias -s proto=vim

alias -g L='2>&1 | less -R'
alias -g G='2>&1 | grep'
alias -g X='| xargs'
alias -g W='| wc'
alias -g H='| head'
alias -g T='| tail'
alias -g P='2>&1 |'
alias -g BG='>/dev/null 2>&1 &'

if (( $+commands[cscope-fast] )); then
    alias csc="cscope-fast -e -p 3 -d -q"
else
    alias csc="cscope -e -p 3 -d -q"
fi
alias csc-build="cscope -bRq"

# handy variables

phx=ssh.phx.nearlyfreespeech.net
test -d $HOME/.templates && templates=$HOME/.templates

# functions

customfpath=(
    $HOME/.zsh/fpath/$(uname -n)
    $HOME/.zsh/fpath/$(uname -s)-$(uname -p 2>/dev/null || uname -m)
    $HOME/.zsh/fpath/$(uname -s)
    $HOME/.zsh/fpath
)
for i in $customfpath; fpath=(${fpath:#$i})
fpath=($customfpath $fpath)
for i in $customfpath; test -d $i && autoload -U $i/*(.:t) || fpath=(${fpath:#$i})
unset customfpath

autoload -U zmv

# completion control

autoload -U compinit && compinit
compinit -d /tmp/.samf.zcompdump

if (( $+commands[kubectl] )); then
    . <(kubectl completion zsh)
fi

# verbosity

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messagesâ' format '%d'
zstyle ':completion:*:warningsâ' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# title bar madness

case "$TERM" in
    xterm*|rxvt)
        precmd ()
        {
            local nobold pstring
            nobold=${PROMPT#%B}
            pstring=${nobold%%%b }
            print -nP "\033]0;${pstring}\007"
        }
        preexec ()
        {
            local nobold pstring cmds
            cmds=($1)
            nobold=${PROMPT#%B}
            pstring=${nobold%%%b }
            print -nP "\033]0;${pstring} $1\007" 2>/dev/null
        }
    ;;
esac

# minimal mercurial and git

[[ -w . && -r ~/.hgrc ]] || ln -s .hgrc-h ~/.hgrc
[[ -w . && -r ~/.gitconfig ]] || ln -s .gitconfig-home ~/.gitconfig

# minimal ssh authorized_keys

if [[ -w .ssh ]]; then
    current=~/.ssh/authorized_keys
    needed=~/.ssh/id_ed25519.pub

    test -e $current || cp -p $needed $current

    unset current needed
fi

# iterm2 integration

. $HOME/.iterm2_shell_integration.zsh

# local customizations

custom=(
    $(uname -s)
    $(uname -s)-$(uname -p 2>/dev/null || uname -m)
    $(uname -n)
)
for i in $custom; test -r $HOME/.zsh/rc/${i%%.*} && . $HOME/.zsh/rc/${i%%.*}
unset custom

# direnv

if (( $+commands[direnv] )); then
    eval "$(direnv hook zsh)"
fi

# make zsh fish again

if [[ $ZSH_VERSION != 5.1.1 ]]; then
    . ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    . ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
