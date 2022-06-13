{{#if dotter.packages.zsh}}
{{#if (eq shell_command "zsh")}}
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$HOME/miniconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
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

function conda_env_and_ls() {
  emulate -L zsh

  FILE="$(find . -regextype posix-extended -maxdepth 1 -regex '.*(env(ironment)?|requirements)\.ya?ml' -print -quit)"
  if [[ -e $FILE ]]; then
    ENV=$(sed -n 's/name: //p' $FILE)
    # check if env already active
    if [[ $CONDA_DEFAULT_ENV != $ENV ]]; then
      # Deactivate main env
      conda deactivate
      # Activate Local env
      conda activate $ENV
      # if env activation unsuccessful, create new env from file
      if [ $? -ne 0 ]; then
        echo "Conda environment '$ENV' doesn't exist. Creating it now."
        conda env create -q -f $FILE
        conda activate $ENV
      fi
      CONDA_ENV_ROOT="$(pwd)"
    fi
  # deactivate env when exciting root dir
  elif [[ $PATH = */envs/* ]]\
    && [[ $(pwd) != $CONDA_ENV_ROOT ]]\
    && [[ $(pwd) != $CONDA_ENV_ROOT/* ]]
  then
    CONDA_ENV_ROOT=""
    # Return to default environment
    conda deactivate
    # If using a different default conda environment name, set it here
    conda activate base
  fi

  # If everything ok, print ls
  {{#if (is_executable "exa")}}exa --icons -h --git -a -F --color-scale --color=always -G -x{{else}}ls{{/if}}
}
chpwd_functions=(${chpwd_functions[@]} "conda_env_and_ls")

source $HOME/.zsh/antigen.zsh

# Load the oh-my-zsh's library
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
# Git helpers
antigen bundle git
# Python pip
antigen bundle pip
# command not found
antigen bundle command-not-found
# Vi-mode for zsh
antigen bundle jeffreytse/zsh-vi-mode
# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
# Fish-like auto-suggestions
antigen bundle zsh-users/zsh-autosuggestions
# FZF autosuggestions
antigen bundle Aloxaf/fzf-tab

# Tell Antigen that you're done.
antigen apply

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="waterfall"

# Load the theme.
antigen theme $ZSH_THEME

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

source $ZSH/oh-my-zsh.sh

# User configuration

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# COND - Is rust installed?
# ----------------------------------
#** Rust - https://www.rust-lang.org/tools/install
export PATH=$HOME/.cargo/bin:$PATH

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# tmux popup - requires tmux 3.2+
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' popup-pad 10 0

#*** ls aliases (requires exa)
alias ls='exa --icons -h --git -a -F --color-scale --color=always -G -x'
alias l='ls -T -L=2'
alias ll='ls -alF'
alias la='ls -a'

#*** Pretty Git Diff
{{#if (is_executable "bat")}}
gdiff() {
  git diff --name-only --diff-filter=d | xargs bat --diff
}
{{else}}
alias gdiff="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n'' %C(white)%s%C(reset)%n'' %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)' --all"
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
eval "$(zoxide init zsh)"
{{/if}}

#** Alias builtin 'cd' to zoxide's 'z' command - https://github.com/ajeetdsouza/zoxide
cd() {
  {{#if (is_executable "zoxide")}}z{{else}}builtin cd{{/if}} "$@" || return $?
}

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
# Default fzf options
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=80%
--multi
--preview-window=:hidden
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt='∼ ' --pointer='▶' --marker='✓'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
--bind 'ctrl-v:execute(code {+})'
--bind 'ctrl-alt-k:up'
--bind 'ctrl-alt-j:down'
"

##** Super Finder - uses [fzf](https://github.com/junegunn/fzf) and [rg](https://github.com/BurntSushi/ripgrep)
# find-in-file - usage: fif <SEARCH_TERM>
sf() {
  # 1. Search for text in files using Ripgrep
  # 2. Interactively restart Ripgrep with reload action
  # 3. Open the file in Vim
  out=$(rg \
	--column \
	--line-number \
	--no-column \
	--no-heading \
	--fixed-strings \
	--ignore-case \
	--hidden \
	--follow \
	--glob '!.git/*' "$1" \
	| awk -F  ":" '/1/ {start = $2<5 ? 0 : $2 - 5; end = $2 + 5; print $1 " " $2 " " start ":" end}' \
	| fzf --preview 'bat --wrap never --color always {1} --highlight-line {2} --line-range {3}')
      read -r filename line <<< "${out}"
      ${EDITOR:-vim} "${filename}" +"normal! ${line}zz"
}

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

# COND - Is deno exe?
# ----------------------------------
#** Deno - https://deno.land/manual/getting_started/installation
export DENO_INSTALL="/home/dan/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"


# COND - Is ruby exe?
# ----------------------------------
#** Ruby - https://www.ruby-lang.org/en/documentation/installation/
export GEM_HOME="$HOME/.gem"
# Add to PATH
export PATH="$HOME/.gem/bin:$PATH"

# COND - Is PHP / Composer installed?
# ----------------------------------
#** Composer
PATH="$HOME/.config/composer/vendor/bin:$PATH";

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

{{#if shell.vimmode}}
# COND - Is vim enabled?
# ----------------------------------
#** Vim-ify
#*** Vim-like navigation in bash
set -o vi
#*** Set vim to be default editor
export VISUAL="vim"

#*** Disable editor shortcut on "v" keypress in prompt
#bind -m vi-command '"v": ""'
#*** Enable edit-and-execute
#bind -m vi-command '"v": edit-and-execute-command'
{{/if}}


# COND - Is pipe-viewer exe?
# ----------------------------------
#* Pipe-Viewer - https://github.com/trizen/pipe-viewer
alias newpipe="pipe-viewer"

# Does save_image_from_clipboard exist?
# ----------------------------------
#* Save Image from Clipboard - https://github.com/cpbotha/save_image_from_clipboard
alias saveclip="save_image_from_clipboard"

# COND - Is alacritty exe?
# ----------------------------------
#** zsh completion
#*** Alacritty zsh completion
#source $HOME/.config/alacritty/__alacritty

#*** Alacritty Themes
#**** Theme switcher function
theme() {
   ColorStart='## <- START ->'
   ColorEnd='## <- END ->'
   color="$(colortty get "$1")" || color="$(colortty get -p gogh "$1")"
   perl -0777 -pi -e 's/'"$ColorStart"'.*?'"$ColorEnd"'/'"$ColorStart\n$color\n$ColorEnd"'/sg;' ~/.config/alacritty/alacritty.yml

   if [[ "$1" = "Gruvbox Dark" || "$1" = "Banana Blueberry" ]]
   then
      echo "gruvbox"
   fi

   if [[ "$1" = "Gruvbox Light" || "$1" = "Tinacious Design (Light)" ]]
   then
      echo "Tomorrow"
   fi

   if [[ "$1" = "Tinacious Design (Dark)" ]]
   then
      echo "material"
   fi

   if [[ "$1" = "Tomorrow" ]]
   then
      echo "$1"
   fi

   if [[ "$1" = "Duotone Dark" ]]
   then
      echo "duotone-dark"
   fi

   if [[ "$1" = "BlulocoLight" ]]
   then
      echo "Tomorrow"
   fi

   if [[ "$1" = "Spacedust" || "$1" = "Tomorrow Night Eighties" || "$1" = "Novel" ]]
   then
      echo "Tomorrow-Night-Eighties"
   fi

   if [[ "$1" = "Scarlet Protocol" ]]
   then
      echo "wellsokai"
   fi

   if [[ "$1" = "Aurora" ]]
   then
      echo "evokai"
   fi

   if [[ "$1" = "Ollie" || "$1" = "Seafoam Pastel" || "$1" = "N0tch2k" || "$1" = "Square" || "$1" = "Teerb" || "$1" = "Neutron" ]]
   then
      echo "wwdc16"
   fi

   if [[ "$1" = "Molokai" || "$1" = "Monokai Remastered" || "$1" = "Monokai Soda" || "$1" = "Lavandula" || "$1" = "Nocturnal Winter" || "$1" = "Urple" ]]
   then
      echo "monokai-phoenix"
   fi

   if [[ "$1" = "Tomorrow Night Bright" || "$1" = "BirdsOfParadise" || $1 = "Monokai Vivid" ]]
   then
      echo "afterglow"
   fi

   if [[ "$1" = "IC_Orange_PPL" ]]
   then
      echo "Atelier_DuneDark"
   fi
}

#** Quick Themes
export VIM_COLOR="$(theme '{{theme}}')"         # Gruvbox Dark

{{#if shell.scripts}}
# Add /usr/local/bin to PATH
export PATH=$PATH:/usr/local/bin
# COND - Is bash.scripts enabled?
# ----------------------------------
for SCRIPT in $(find "$HOME/.dotfiles/scripts/" -type f)
do
  if [[ "$SCRIPT" == *.sh ]]
  then
    [ -f "$SCRIPT" ] && source "$SCRIPT"
  else
    SCRIPT_FILE=`basename $SCRIPT`
    [ -f "$SCRIPT_FILE" ] && [ ! -L "$HOME/.local/bin/$SCRIPT_FILE" ] && ln -s "$SCRIPT" "$HOME/.local/bin/$SCRIPT_FILE"
  fi
done
{{/if}}

{{#if shell.shift}}
# source "$HOME/.dotfiles/scripts/shift.sh"
{{/if}}

# Java Decompiler and LSP
# -----------------------------------
# must install JDK 11:
# sudo apt-get install openjdk-11-jdk
# -----------------------------------
export JDK_HOME='/usr/lib/jvm/java-1.11.0-openjdk-amd64'

# The following lines were added by compinstall
zstyle :compinstall filename '/home/dan/.zshrc'
# partial completion suggestions
zstyle ':completion:*' list-suffixes zstyle ':completion:*' expand prefix suffix 
autoload -Uz compinit
compinit
# End of lines added by compinstall

export ZSH_AUTOSUGGEST_STRATEGY=(
    history
    completion
)
{{/if}}
{{/if}}
