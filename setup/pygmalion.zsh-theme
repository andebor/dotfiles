# Yay! High voltage and arrows!

prompt_setup_pygmalion(){
  setopt localoptions extendedglob

  ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
  ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}⚡%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_CLEAN=""

  ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="%{$fg_bold[red]%}("
  ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX=")%{$reset_color%}"
  

  base_prompt='%{$fg[magenta]%}%n%{$reset_color%}%{$fg[cyan]%}@%{$reset_color%}%{$fg[red]%}%m%{$reset_color%}%{$fg[red]%}:%{$reset_color%}%{$fg[cyan]%}%0~%{$reset_color%}%{$fg[red]%}|%{$reset_color%}'
	post_prompt='%{$fg[cyan]%}⇒%{$reset_color%}  '

  base_prompt_nocolor=${base_prompt//\%\{[^\}]##\}}
  post_prompt_nocolor=${post_prompt//\%\{[^\}]##\}}

  autoload -U add-zsh-hook
  add-zsh-hook precmd prompt_pygmalion_precmd
}

prompt_pygmalion_precmd(){
  local gitinfo=$(git_prompt_info)
  local gitinfo_nocolor=${gitinfo//\%\{[^\}]##\}}
  local exp_nocolor="$(print -P \"${base_prompt_nocolor}${gitinfo_nocolor}${post_prompt_nocolor}\")"
  local prompt_length=${#exp_nocolor}
  local env_info=$(virtualenv_prompt_info)
  local notifier='$(f_notifyme)'

  local nl=""

  if [[ $prompt_length -gt 40 ]]; then
    nl=$'\n%{\r%}';
  fi
  PROMPT="${notifier}${env_info}${base_prompt}${gitinfo}${nl}${post_prompt}"
}

prompt_setup_pygmalion
