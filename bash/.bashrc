{{#if dotter.packages.bash}}
{{#if (eq shell_command "bash")}}
#BEGIN - Table of Contents ====================================

   #  File Information
   #  Bash Settings
     #  Only run interactively
     #  Ignore duplicate lines
     #  History
       #  Don't overwrite history
       #  Set history length
     #  Adjust window size
     #  Don't wrap lines
     #  Match directories and subdirecties
     #  Make less more friendly
     #  Prompt
       #  Set chroot var
       #  Fancy prompt
       #  Colored prompt
         #  Set colored prompt
         #  Unset force color
     #  Vim-ify
       #  Vim-like navigation in bash
       #  Set vim to be default editor
       #  Disable editor shortcut on "v" keypress in prompt
       #  Enable edit-and-execute
   #  Conda Init
     #  Conda Auto Env script:
     #  Remove conda env
   #  Virtual Env
     #  Setup virtual env prompt info
     #  Virtual Env Wrapper
     #  Git repo
       #  Pretty Git Diff
     #  Prevent directory from wrapping
   #  Quickeasy prompt text decorations
     #  Color changed on input
     #  Quickeasy prompt colors
   #  Ultimate PS1
     #  Use Neovim if available
     #  Setup zoxide
     #  Alias builtin 'cd' to zoxide's 'z' command - https:github.comajeetdsouzazoxide
     #  Alias builtin 'cat' command to 'bat' command - https:github.comsharkdpbat
     #  ripgrep
     #  fzf
     #  Python 3
       #  td-cli home - https:github.comdarrikonntd-cli
       #  Jupyter Notebook
     #  GO - https:go.devdocinstall
     #  Perl - https:learn.perl.orginstalling
     #  NVM - https:github.comnvm-shnvm
     #  Ruby - https:www.ruby-lang.orgendocumentationinstallation
     #  Composer
     #  Rust - https:www.rust-lang.orgtoolsinstall
     #  Start MPD daemon
     #  TMux
       #  Run Tmux on startup
       #  Tmux Aliases
       #  Extra Tmux
       #  Tmux
   #  Pipe-Viewer - https:github.comtrizenpipe-viewer
     #  Bash completion
       #  Alacritty Bash Completion
       #  Alacritty Themes
         #  Theme switcher function
     #  Quick Themes
       #  Light Themes
       #  Dark Themes

#END   - Table of Contents ====================================

#* File Information

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#* Bash Settings

#** Only run interactively
# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

#** Ignore duplicate lines
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

#** History
#*** Don't overwrite history
# append to the history file, don't overwrite it
shopt -s histappend

#*** Set history length
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=10000

#** Adjust window size
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

#** Don't wrap lines
#setterm --linewrap off

#** Match directories and subdirecties
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

#** Make less more friendly
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#** Prompt
#*** Set chroot var
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

#*** Fancy prompt
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac

#*** Colored prompt
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

#**** Set colored prompt
if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
  else
  color_prompt=
  fi
fi

#**** Unset force color
if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*)
  ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  {{#if (is_executable "exa")}}
  alias ls='exa --icons -h --git -a -F --color-scale --color=always -G -x'
  alias l='ls -T -L=2'
  {{else}}
  alias ls='ls --color=auto -F'
  {{/if}}
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -a'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# For bash argument completion, the following is recommended:
# https://pypi.org/project/argcomplete/

{{#if shell.vimmode}}
# COND - Is vim enabled?
# ----------------------------------
#** Vim-ify
#*** Vim-like navigation in bash
set -o vi
#*** Set vim to be default editor
export VISUAL=vim
#WIP
#get_cursor_pos() {
#  # Usage: get_cursor_pos
#  IFS='[;' read -p $'\e[6n' -d R -rs _ y x _
#  printf '%s\n' "$x $y"
#}
#get_cursor_row() {
#  local COL
#  local ROW
#  IFS=';' read -sdR -p $'\E[6n' ROW COL
#  echo "${ROW#*[}"
#}
#get_cursor_col() {
#  local COL
#  local ROW
#  IFS=';' read -sdR -p $'\E[6n' ROW COL
#  echo "${COL}"
#}
#export VISUAL="vim \"+call cursor(1, $(get_cursor_col)) | Vb\""

#*** Disable editor shortcut on "v" keypress in prompt
#bind -m vi-command '"v": ""'
#*** Enable edit-and-execute
bind -m vi-command '"v": edit-and-execute-command'
{{/if}}


{{#if (is_executable "ifdata")}}
export ip4=$(ifdata -pa wlp2s0)
{{#if (is_executable "browser-sync")}}
alias serve="browser-sync start -s -f . --extensions 'html' --no-notify --host $ip4 --port 9000"
{{/if}}
{{/if}}

#* Conda Init
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$HOME/miniconda3/bin/conda" "shell.bash" "hook" 2> /dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
      . "$HOME/miniconda3/etc/profile.d/conda.sh"
  else
      export PATH="$HOME/miniconda3/bin:$PATH"
  fi
fi
unset __conda_setup
# <<< conda initialize <<<

#** Conda Auto Env script:
# http://albertotb.com/Git-prompt-with-conda-and-conda-auto-env/
alias conda_env_make='conda env export > environment.yml'
if [ -f $HOME/.local/bin/conda_auto_env.sh ]; then
  source $HOME/.local/bin/conda_auto_env.sh
fi


# COND - mkvirtualenv
# -------------------------------------
#* Virtual Env
#** Setup virtual env prompt info
__virtualenv_info() {
  # Get Virtual Env
  if [[ -n "$VIRTUAL_ENV" ]]; then
    # Strip out the path and just leave the env name
    venv="${VIRTUAL_ENV##*/}"
  else
    # In case you don't have one activated
    venv=''
  fi
  [[ -n "$venv" ]] && echo "($venv) "
}
VENV="\$(__virtualenv_info)";

#** Virtual Env Wrapper
export WORKON_HOME="$HOME/.virtualenvs"
export VIRTUAL_ENV_DISABLE_PROMPT=1
VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3"
source $HOME/.local/bin/virtualenvwrapper.sh

# COND - git
# -------------------------------------
#** Git repo
__git_repo() {
  echo " $(basename -s .git `git config --get remote.origin.url` 2>/dev/null)"
}
export -f __git_repo

#*** Pretty Git Diff
{{#if (is_executable "bat")}}
gdiff() {
  git diff --name-only --diff-filter=d | xargs bat --diff
}
export -f gdiff
{{else}}
alias gdiff="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n'' %C(white)%s%C(reset)%n'' %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)' --all"
{{/if}}

#** Prevent directory from wrapping
__shortpath() {
  term_width=$(tmux display -p '#{pane_width}' || echo "0")
  if [[ ${#term_width} > 1 ]]; then
    term_width=$(tput cols)
  fi
  venv_width=${#VENV}
  cenv_width=${#CONDA_DEFAULT_ENV}
  git_repo=$(__git_repo)
  width=${term_width}-${#git_repo}-35-${cenv_width}-${venv_width}
  if [[ ${#1} -gt width ]]; then
    len=width-10
    echo "..."${1: -$len}
  else
    echo $1
  fi
}
export -f __shortpath

#* Quick/easy prompt text decorations
ansi()          { echo -e "\e[${1}m${*:2}\e[0m"; }
bold()          { ansi 1 "$@"; }
italic()        { ansi 3 "$@"; }
underline()     { ansi 4 "$@"; }
strikethrough() { ansi 9 "$@"; }

#** Color changed on input
# Change color of the PS1 prompt time bashed on bash output
__color_change() {
   if [ $? == 0 ]; then
      Gre
   else
      Red
   fi
}
export -f __color_change

#** Quick/easy prompt colors
Man() { echo -e "\033[0m"; }
Blu() { echo -e "\033[36m"; }
Gol() { echo -e "\033[34m"; }
Yel() { echo -e "\033[33m"; }
Gre() { echo -e "\033[32m"; }
Red() { echo -e "\033[31m"; }

#* Ultimate PS1
# Additionally, the second line of the prompt is handled
# in the ~/.inputrc file. This allows (ins) or (cmd) mode
# to be visible while "set -o vi" is set
ultimate_ps1() {
  PS1="$(Man)┎─〚(${CONDA_DEFAULT_ENV}) \`__color_change\`${VENV}\T$(Man)\] \[$(Blu)\]\u@\h \[$(Yel)\]\`__shortpath '\w'\`$(Man)\]$(bold $(italic \`__git_repo\`))\`__git_ps1 ' $(bold $(italic  %s)) '\`\] 〛\n" # Add '┗━━━━━━━━▶ ' to the end if not using inputrc
}
export -f ultimate_ps1

export PROMPT_COMMAND="conda_auto_env;ultimate_ps1"

{{#if (is_executable "nvim")}}
# COND - Is nvim exe?
# ------------------------------------
#** Use Neovim if available
alias vim='nvim'
{{/if}}

{{#if (is_executable "kunst")}}
# COND - Is kunst exe?
# -----------------------------------
# Kunst - Used for downloading and displaying album artwork
# https://github.com/sdushantha/kunst
export KUNST_SIZE="250x250"
export KUNST_POSITION="+0+0"
export KUNST_MUSIC_DIR="/media/$USER/MUSIC/" # Using a micro SD card to play music
{{/if}}

{{#if (is_executable "zoxide")}}
# COND - Is zoxide exe?
# -----------------------------------
#** Setup zoxide
eval "$(zoxide init bash)"
{{/if}}

#** Alias builtin 'cd' to zoxide's 'z' command - https://github.com/ajeetdsouza/zoxide
cd() {
  {{#if (is_executable "zoxide")}}z{{else}}builtin cd{{/if}} "$@" || return $?
  # If everything ok, print ls
  ls
}
export -f cd

{{#if (is_executable "bat")}}
# COND - Is bat exe?
# -----------------------------------
#** Alias builtin 'cat' command to 'bat' command - https://github.com/sharkdp/bat
# https://github.com/sharkdp/bat
alias cat="bat"
{{/if}}

# COND - Is rg exe?
# ----------------------------------

#** ripgrep
# --------------------
# Ripgrep settings path
export RIPGREP_CONFIG_PATH={{ripgrep_config_path}}
# Set default fzf command options
export RG_PREFIX="rg --files --hidden --follow --smart-case --glob '!.git' "

#** fzf
# --------------------
# Requires newer version of fzf v0.29+
# Need GO to install
# --------------------
export INITIAL_QUERY=""
# fzf bash completion using '**'
[ -f $HOME/.dotfiles/bash/.fzf.bash ] && source $HOME/.dotfiles/bash/.fzf.bash
# Default fzf options
export FZF_DEFAULT_OPTS='--bind=ctrl-alt-k:up,ctrl-alt-j:down'
export FZF_DEFAULT_COMMAND=$RG_PREFIX
# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

##** Super Finder - uses [fzf](https://github.com/junegunn/fzf) and [rg](https://github.com/BurntSushi/ripgrep)
sf() {
  # 1. Search for text in files using Ripgrep
  # 2. Interactively restart Ripgrep with reload action
  # 3. Open the file in Vim
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  INITIAL_QUERY="${*:-}"
  IFS=: read -ra selected < <(
    FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")" \
    fzf --ansi \
        --disabled --query "$INITIAL_QUERY" \
        --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
  )
  [ -n "${selected[0]}" ] && vim "${selected[0]}" "+${selected[1]}"
}
export -f sf

# COND - Is python exe?
# -----------------------------------
#** Python 3
alias python=python3
#*** td-cli home - https://github.com/darrikonn/td-cli
export TD_CLI_HOME=$HOME/.scratch/
#*** Jupyter Notebook
alias jupcon='jupyter console'

# COND - Is go exe?
# -----------------------------------
#** GO - https://go.dev/doc/install
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# COND - Is perl exe?
# ----------------------------------
#** Perl - https://learn.perl.org/installing/
PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

# COND - Is nvm exe?
# ----------------------------------
#** NVM - https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# COND - Is ruby exe?
# ----------------------------------
#** Ruby - https://www.ruby-lang.org/en/documentation/installation/
export GEM_HOME="$HOME/.gem"

# COND - Is PHP / Composer installed?
# ----------------------------------
#** Composer
PATH="$HOME/.config/composer/vendor/bin:$PATH";

# COND - Is rust installed?
# ----------------------------------
#** Rust - https://www.rust-lang.org/tools/install
export PATH=$HOME/.cargo/bin:$PATH

{{#if shell.mpd}}
# COND - Is mpd enabled?
# ----------------------------------
#** Start MPD daemon
[ ! -s ~/.config/mpd/pid ] && mpd
{{/if}}


# COND - Is tmux exe?
# ----------------------------------
#** TMux

#*** Run Tmux on startup
# Command to run TMUX at each terminal startup,
# uses incrementing session name:
# ----------------------------------------
SESSION_PREFIX="main"
TMUX_BIN="$(which tmux)"
if [ "$SSH_CLIENT" = "" ] # local terminal emulator or tty
then
  if [[ -n "$PS1" ]] && [[ -z ${TMUX} ]] # If TMUX session already exists:
  then
    ACTIVE=$($TMUX_BIN ls -F '#S' 2>/dev/null || echo "false") # Get list of active tmux session, or set false
    if [[ $ACTIVE = "false" ]]
    then
      # If session doesn't exist, start new one
      $TMUX_BIN new -s "$SESSION_PREFIX-0" -c "$PWD" 2>/dev/null && exit
    else
      # If session exists, increment from most recent
      ACTIVE="${ACTIVE//[!0-9[:space:]]/}" # Remove non-numeric / space characters
      ACTIVE=($ACTIVE) # Convert to array
      COUNT=$(echo "${#ACTIVE[@]}")
      if [[ $COUNT -gt 0 ]]
      then
        if [[ $COUNT -gt 1 ]] # More than one TMUX session already exist
        then
          max=${ACTIVE[0]}
          for sess in ${ACTIVE[@]}
          do
            ((sess > max)) && max=$sess
          done
          INCREMENTED=$(($max+1))
          SESSION_INCREMENTED="$SESSION_PREFIX-$INCREMENTED"
          # Starts new tmux session using increment of largest session number
          $TMUX_BIN new -s "$SESSION_INCREMENTED" -c "$PWD" 2>/dev/null && exit
        else
          # Only one session is active
          ACTIVE=$(echo ${ACTIVE[0]} | awk -F- '{print $NF}')
          INCREMENTED=$(($ACTIVE+1))
          SESSION_INCREMENTED="$SESSION_PREFIX-$INCREMENTED"
          $TMUX_BIN new -s "$SESSION_INCREMENTED" -c "$PWD" 2>/dev/null && exit
        fi
      fi
    fi
  else
    # No sessions, start new one
    $TMUX_BIN new -s "$SESSION_PREFIX-0" -c "$PWD" 2>/dev/null && exit
  fi
fi

#*** Tmux Aliases
alias tls="tmux ls"
alias t0="tmux attach -t $SESSION_PREFIX-0"
alias t1="tmux attach -t $SESSION_PREFIX-1"
alias t2="tmux attach -t $SESSION_PREFIX-2"
alias t3="tmux attach -t $SESSION_PREFIX-3"
alias t4="tmux attach -t $SESSION_PREFIX-4"
alias t5="tmux attach -t $SESSION_PREFIX-5"
alias t6="tmux attach -t $SESSION_PREFIX-6"
alias t7="tmux attach -t $SESSION_PREFIX-7"
alias t8="tmux attach -t $SESSION_PREFIX-8"
alias t9="tmux attach -t $SESSION_PREFIX-9"
alias k0="tmux kill-session -t $SESSION_PREFIX-0"
alias k1="tmux kill-session -t $SESSION_PREFIX-1"
alias k2="tmux kill-session -t $SESSION_PREFIX-2"
alias k3="tmux kill-session -t $SESSION_PREFIX-3"
alias k4="tmux kill-session -t $SESSION_PREFIX-4"
alias k5="tmux kill-session -t $SESSION_PREFIX-5"
alias k6="tmux kill-session -t $SESSION_PREFIX-6"
alias k7="tmux kill-session -t $SESSION_PREFIX-7"
alias k8="tmux kill-session -t $SESSION_PREFIX-8"
alias k9="tmux kill-session -t $SESSION_PREFIX-9"

#*** Extra Tmux
alias tirss='tmux attach -t irssi'
alias tslack='tmux attach -t slack'

#*** Tmux
alias LS='tmux split-window -hbdl 30 "tmux-filetree"'
#alias LS='tmux resize-pane -x 30; while sleep 1; do clear && ls -a "$(tmux display-message -p -F "#{pane_current_path}" -t1)"; done'
#livels() { while :; do clear; tmux display-message -p -F "#{pane_current_path}" -t0 | xargs tree -L 1 ; sleep 1; done }
#export -f livels

# COND - Is pipe-viewer exe?
# ----------------------------------
#* Pipe-Viewer - https://github.com/trizen/pipe-viewer
alias newpipe="pipe-viewer"

# COND - Is alacritty exe?
# ----------------------------------
#** Bash completion
#*** Alacritty Bash Completion
source $HOME/.config/alacritty/alacritty.bash

#*** Alacritty Themes
#**** Theme switcher function
function theme() {
   ColorStart='## <- START ->'
   ColorEnd='## <- END ->'
   color="$(colortty get "$1")" || color="$(colortty get -p gogh "$1")"
   perl -0777 -pi -e 's/'"$ColorStart"'.*?'"$ColorEnd"'/'"$ColorStart\n$color\n$ColorEnd"'/sg;' ~/.config/alacritty/alacritty.yml

   if [[ "$1" == "Gruvbox Dark" || "$1" == "Banana Blueberry" ]]
   then
      echo "gruvbox"
   fi

   if [[ "$1" == "Gruvbox Light" || "$1" == "Tinacious Design (Light)" ]]
   then
      echo "earthburn"
   fi

   if [[ "$1" == "Tinacious Design (Dark)" ]]
   then
      echo "material"
   fi

   if [[ "$1" == "Tomorrow" ]]
   then
      echo "$1"
   fi

   if [[ "$1" == "Duotone Dark" ]]
   then
      echo "duotone-dark"
   fi

   if [[ "$1" == "BlulocoLight" ]]
   then
      echo "Tomorrow"
   fi

   if [[ "$1" == "Spacedust" || "$1" == "Tomorrow Night Eighties" || "$1" == "Novel" ]]
   then
      echo "Tomorrow-Night-Eighties"
   fi

   if [[ "$1" == "Scarlet Protocol" ]]
   then
      echo "wellsokai"
   fi

   if [[ "$1" == "Aurora" ]]
   then
      echo "evokai"
   fi

   if [[ "$1" == "Ollie" || "$1" == "Seafoam Pastel" || "$1" == "N0tch2k" || "$1" == "Square" || "$1" == "Teerb" || "$1" == "Neutron" ]]
   then
      echo "wwdc16"
   fi

   if [[ "$1" == "Molokai" || "$1" == "Monokai Remastered" || "$1" == "Monokai Soda" || "$1" == "Lavandula" || "$1" == "Nocturnal Winter" || "$1" == "Urple" ]]
   then
      echo "monokai-phoenix"
   fi

   if [[ "$1" == "Tomorrow Night Bright" || "$1" == "BirdsOfParadise" || $1 == "Monokai Vivid" ]]
   then
      echo "afterglow"
   fi

   if [[ "$1" == "IC_Orange_PPL" ]]
   then
      echo "Atelier_DuneDark"
   fi
}
export -f theme

#** Quick Themes
export VIM_COLOR="$(theme '{{theme}}')"         # Gruvbox Dark

{{#if shell.scripts}}
# Add /usr/local/bin to PATH
export PATH=$PATH:/usr/local/bin
# COND - Is bash.scripts enabled?
# ----------------------------------
for SCRIPT in $(find "$HOME/.dotfiles/scripts/")
do
  [ -f "$SCRIPT" ] && source "$SCRIPT"
done
{{/if}}

{{#if shell.shift}}
# source "$HOME/.dotfiles/scripts/shift.sh"
{{/if}}

source "$HOME/.poetry/env"

{{/if}}
{{/if}}
