#! /bin/zsh

# zsh options

bindkey -e

setopt auto_cd auto_name_dirs auto_pushd auto_resume pushd_ignore_dups
setopt dvorak hist_ignore_dups hist_ignore_space hist_no_store noclobber
setopt hist_allow_clobber short_loops nobeep cdable_vars interactive_comments
setopt no_nomatch glob_assign print_exit_value

REPORTTIME=1

# zsh variables

PROMPT="%B${wsname:-%m}/%!/%(#.#.*)%b "
RPROMPT="%B%~ %T%b"
TMOUT=120

# environment variables

setopt all_export

HISTSIZE=16384
PAGER=less
LESS=isXR
EDITOR=vi
BAT_THEME=Coldark-Dark

tzwant=/usr/share/zoneinfo/US/Mountain
[[ -r $tzwant ]] && TZ=$tzwant

unset ENV tzwant

# paths

prepath=(
    $HOME/$(uname -n)/bin
    $HOME/$(uname -s)-$(uname -p 2>/dev/null || uname -m)/bin
    $HOME/$(uname -s)/bin
    $HOME/src/gocode/bin
    /opt/homebrew/bin
    /opt/homebrew/sbin
    $HOME/.cargo/bin
    $HOME/.local/bin
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

alias mvi='mv -i'
alias cpi='cp -i'

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

alias crd='npx cypress open --env baseUrl=https://efmrl.net:8443/efmrl-api/,sBaseUrl=https://s.efmrl.net:8443/efmrl-api/,testBaseUrl=https://test.efmrl.net:8443/efmrl-api/,devBaseUrl=https://efmrl.net:8443/efmrl-api/sb/dev/'
alias crp='npx cypress open --env baseUrl=https://efmrl.com/efmrl-api/,sBaseUrl=https://s.efmrl.com/efmrl-api/,testBaseUrl=https://test.efmrl.com/efmrl-api/,devBaseUrl=https://efmrl.com/efmrl-api/sb/dev/'


if (( ! $+commands[reset] )); then
    alias reset='echo -e "\033c"'
fi

alias -s go=vim
alias -s {yml,yaml}=vim
alias -s taskpaper=vim

alias -g L='2>&1 | less -R'
alias -g G='2>&1 | grep'
alias -g J='| jq'
alias -g X='| xargs'
alias -g W='| wc'
alias -g H='| head'
alias -g T='| tail'
alias -g P='2>&1 |'
alias -g S='| sort'
alias -g C='| cut -c-$COLUMNS'
alias -g BG='>/dev/null 2>&1 &'
alias -g LC='| lolcat'

# handy variables

phx=ssh.phx.nearlyfreespeech.net
marshall='/Users/samf/Library/Mobile Documents/com~apple~CloudDocs/Marshall fire'
json='application/json'

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

autoload -U compinit && compinit -u
compinit -u -d /tmp/.${USER}.zcompdump

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

# use fzf if present

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if (( $+commands[fd] )); then
    FZF_ALT_C_COMMAND="fd --no-ignore-vcs --hidden -t d . $HOME"
fi
