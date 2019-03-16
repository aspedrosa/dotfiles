local _host_user="%{$fg[red]%}%n @ %m%{$reset_color%}"
local _pwd="%{$fg_bold[cyan]%}%~%{$reset_color%}"
local _return_status=" %{$fg_bold[red]%}%(?..⍉)%{$reset_color%}"
local _prompt="%{$fg[yellow]%}$%{$reset_color%} "

PROMPT='${_host_user} $(git_prompt_info) ${_pwd} ${_return_status}
${_prompt}'
RPROMPT='$(vi_mode_prompt_info)'

ZSH_THEME_PROMPT_RETURNCODE_PREFIX="%{$fg_bold[red]%}"
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[green]%}) %{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"

MODE_INDICATOR="%{$fg_bold[yellow]%}NORMAL%{$reset_color%}"
