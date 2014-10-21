function current_branch() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	echo ${ref#refs/heads/} ''
}

function term_title() {
    echo -ne "\033]0;"$1"\007"
}
    
function reset_terminal() {
    reset
    term_title "Terminal"
}

function whiteboard() {
    convert "$1" -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 "$2"
}

DEF="\[\033[1;0m\]"
RED="\[\033[1;31m\]"
GRE="\[\033[1;32m\]"
YEL="\[\033[1;33m\]"
BLU="\[\033[1;34m\]"
PUR="\[\033[1;35m\]"
CYA="\[\033[1;36m\]"
export PS1="(\$(date +'%H:%M:%S'))$BLU\u$DEF@$CYA\h$DEF $YEL\w $GRE\$(current_branch)$RED$ $DEF"

[[ -f $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
alias reset=reset_terminal
