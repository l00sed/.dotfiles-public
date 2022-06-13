setopt prompt_subst

() {

local PR_USER PR_USER_OP PR_PROMPT PR_HOST

# Check the UID
if [[ $UID -ne 0 ]]; then # normal user
  PR_USER='%F{green}%n%f'
  PR_USER_OP='%F{green}%#%f'
  PR_PROMPT='%f▶ %f'
else # root
  PR_USER='%F{red}%n%f'
  PR_USER_OP='%F{red}%#%f'
  PR_PROMPT='%F{red}▶ %f'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  PR_HOST='%F{red}%M%f' # SSH
else
  PR_HOST='%F{green}%M%f' # no SSH
fi


local return_code="%(?..%F{red}%? ↵%f)"

local user_host="${PR_USER}%F{cyan}@${PR_HOST}"
# Full, unabbreviated CWD
#local current_dir="%B%F{blue}%~%f%b"
# First number is number of directories deep to start abbreviating
# Second number is how many up from the current CWD to show
local current_dir="%B%F{blue}%(4~|.../%2~|%~)%f%b"

# get the name of the branch we are on
BRANCH_SYMBOL=
_git_repo() {
  REPO="$(basename -s .git `git config --get remote.origin.url` 2>/dev/null)" || "false"
  if [[ $REPO != "false" && $REPO != "" ]]
  then
    echo "${REPO}"
  else
    echo ""
  fi
}

_git_branch_dirty() {
  BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/*\(.*\)/\1/')
  if [ ! -z $BRANCH ]; then
    echo -n "${BRANCH_SYMBOL}%F{yellow}$BRANCH%F{reset}"
    if [ ! -z "$(git status --short)" ]; then
      echo " %F{red}✗%F{reset}"
    fi
  fi
}

local GIT_PROMPT='$(_git_repo) $(_git_branch_dirty)'

precmd() {
  psvar[1]=$CONDA_DEFAULT_ENV:t
}

PROMPT="┎─〚(%F{yellow} %1v %F{reset}) ${user_host} ${current_dir} \$(ruby_prompt_info)${GIT_PROMPT} 〛
┗━━━━━━━━$PR_PROMPT "
RPROMPT="${return_code}"

ZSH_THEME_RUBY_PROMPT_PREFIX="%F{red}("
ZSH_THEME_RUBY_PROMPT_SUFFIX=")%f"

function zle-line-init zle-keymap-select {
  RPS1="${${KEYMAP/vicmd/NORMAL}/(main|viins)/INSERT}"
  if [[ "$RPS1" = "NORMAL" ]]
  then
    RPS1="%F{red}%B%b%F{reset}"
  fi
  if [[ "$RPS1" = "INSERT" ]]
  then
    RPS1="%F{red}%B%b%F{reset}"
  fi
  RPS2+=$RPS1
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

}
