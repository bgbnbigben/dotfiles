# Modified version of the af-magic theme

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

ZSH_THEME_VIRTUALENV_PREFIX="%{$fg[green]%}(working on %{$fg_bold[green]%}"
ZSH_THEME_VIRTUALENV_SUFFIX=")%{$reset_color%} "

# primary prompt
PROMPT='%{$reset_color%}\
[$(date +'%H:%M:%S')] $(virtualenv_prompt_info)%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}%m \
%{$FG[032]%}%4(c:%-1~/.../%2~:%~)\
%{$reset_color%}$(prompt_git_info) \
$FG[105]%(!.#.$)%{$reset_color%} '
#PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'

#%{$(git_state_colour)%}$(git_prompt_info) \
# color vars
eval my_gray='$FG[237]'
eval my_orange='$FG[214]'

# git settings

# Show different symbols as appropriate for various Git repository states
#
function prompt_git_info() {
    if [ -n "$__CURRENT_GIT_STATUS" ]; then
        echo " (on %{${fg_bold[cyan]}%}$__CURRENT_GIT_STATUS[1]%{${fg_bold[yellow]}%}$__CURRENT_GIT_STATUS[2]%{${fg[green]}%}$__CURRENT_GIT_STATUS[3]%{${fg_no_bold[default]}%})"
    fi
}

ZSH_THEME_GIT_PROMPT_PREFIX=" (on "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_SUFFIX=")"

setopt prompt_subst
autoload -U colors && colors # Enable colors in prompt
