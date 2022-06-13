#BEGIN - Table of Contents ====================================

   #  Kill Process with FZF
     #  fkill

#END   - Table of Contents ====================================

# These scripts require fzf
# $ sudo apt-get install fzf

#* Kill Process with FZF
# ----------------------
#** fkill
# Kill a process by finding it with fzf
# ----------------------
fkill() {
  pid=$(ps -ef | sed 1d | fzf -m -e --ansi --color --height 40%  --border --prompt="-> " | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}

#* FZF Dictionary
# ----------------------
#** spell
# Use `fzf` against system dictionary,
# requires 'dict', 'dictd', and 'dict-gcide'
# $ sudo apt-get install dict dictd dict-gcide
spell() {
  cat /usr/share/dict/words | fzf --preview 'dict {} | colorit' --preview-window=up:60%
}
#** fdict
# Find word definitions using fzf
fdict() {
  if [ $# -eq 0 ]; then
    dict `spell` | fold
  else
    dict $1 | fold
  fi
}
