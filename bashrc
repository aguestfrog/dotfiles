# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

# set path
if [ -d "$HOME/bin" ]; then
    PATH="$PATH:$HOME/bin"
fi

if [ -d "$HOME/.cabal/bin" ]; then
    PATH="$PATH:$HOME/.cabal/bin"
fi

# append to the history file, don't overwrite it
shopt -s histappend

# resize terminal
shopt -s checkwinsize

# change the window title of X terminals
case ${TERM} in
    xterm*|rxvt*|Eterm|aterm|kterm|gnome*|interix)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/  ~}\007"'
        ;;
    screen)
        PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/    ~}\033\\"'
        ;;
esac

# gentoo color prompt
if [[ ${EUID} == 0 ]] ; then
    PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
else
    PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \W \$\[\033[00m\] '
fi

# alias
alias ls='ls --color=auto -F'
alias ll='ls --color=auto -lFCh'
alias la='ls --color=auto -A'
alias l='ls --color=auto -CF'
alias grep='grep --colour=auto'

# custom inputrc
export INPUTRC=~/.inputrc
alias mounts="mount | column -t"
wiki() { dig +short txt $1.wp.dg.cx; }
#perl -ne 'print  if s/.*(\d{4}).*/\1/' file
