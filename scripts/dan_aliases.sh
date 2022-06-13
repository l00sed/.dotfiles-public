#!/bin/bash
#BEGIN - Table of Contents ====================================

   #  Personal bash aliases
     #  Simple server with Node
     #  Convenient home alias
     #  Linux modules reload (Sound still requires restart)
     #  Use "Trash" utility instead of bash rm for recoverability
     #  ARBTT - Automatic, rule-based time tracking
     #  Knowledge Base
   #  Dumb fun stuff
     #  Sexy Window with Shadow Screenshot
     #  Internet Radio
     #  Scrot utility
     #  Animated terminal screensaver
   #  Nautilus (Linux File Manager)

#END   - Table of Contents ====================================

#* Personal bash aliases

#** Simple server with Node
alias serve='browser-sync start -s'

#** Convenient home alias
alias home="cd $HOME"
alias dhome="cd $HOME/.dotfiles/"
alias lhome="cd $HOME/projects/l-o-o-s-e-d/"
alias brcedit="vim ~/.dotfiles/bash/.bashrc"
alias vrcedit="vim ~/.dotfiles/vim/.vimrc"

dotup() {
  cd $HOME/.dotfiles && dotter -f && cd -
  tmux source-file "$HOME/.tmux.conf"
  if [ "$SHELL" = "/bin/zsh" ];then
    source $HOME/.zshrc
  fi
  if [ -z "$BASH" ];then
    source $HOME/.bashrc
  fi
}

#** Linux modules reload (Sound still requires restart)
alias fixWIFI='sudo dpkg -i $HOME/Downloads/fixWIFI/bcmwl-kernel-source_6.30.223.271+bdcom-0ubuntu5_amd64.deb'
#alias fixWIFI='sudo apt-get install --reinstall --upgrade bcmwl-kernel-source'
alias fixSOUND='sudo pulseaudio -k && alsa force-reload'

#** Use "Trash" utility instead of bash rm for recoverability
# Requires 'trash-cli'
alias rm='trash -v'

#** ARBTT - Automatic, rule-based time tracking
# Get dump of today's activities
ttdumpall() {
  arbtt-stats --dump-samples
}
# Get dump of today's activities
ttdump() {
  arbtt-stats --filter='$date>='`date +"%Y-%m-%d"` --dump-samples
}
# Get organized timeline today's activities
ttt() {
  arbtt-stats --filter='$date>='`date +"%Y-%m-%d"` --output-format=csv -c "Activity" | arbtt-chart --subtags
}
# Get organized timeline today's activities
tty() {
  arbtt-stats --filter='$date>='`date --date="yesterday" +"%Y-%m-%d"` --output-format=csv -c "Activity" | arbtt-chart --subtags
}
# Get specific day
# Example usage: ttt "today"
#                ttt "2 days ago"
ttd() {
  start_date=`date --date="$1" +"%Y-%m-%d"`
  end_date=`date --date="$1 +1 day" +"%Y-%m-%d"`
  arbtt-stats --filter='$date>='$start_date' && $date<='$end_date --output-format=csv -c "Activity" | arbtt-chart --subtags
}
# Get organized timeline today's programs
ttp() {
  arbtt-stats --filter='$date>='`date +"%Y-%m-%d"` --output-format=csv -c "Program" | arbtt-chart --subtags
}
# Get organized timeline of all today's categories
ttec() {
  arbtt-stats --filter='$date>='`date +"%Y-%m-%d"` --output-format=csv --each-category | arbtt-chart --subtags
}

#** Knowledge Base
alias wiki="cd $HOME/projects/l-o-o-s-e-d/html/kb/markdown/"

# The 'generate-md' command is made available with the [markdown styles](https://github.com/mixu/markdown-styles) Node.js package
alias mkhtml='generate-md --input ./ --output ../ --layout ../loosed-template'

#* Dumb fun stuff

#** Sexy Window with Shadow Screenshot
alias omsse='mpv --no-terminal /usr/share/sounds/freedesktop/stereo/camera-shutter.oga'

#** Internet Radio
alias WESA='mpv https://ais-sa3.cdnstream1.com/2556_128.mp3?uuid=ku4qqb6a'
alias WBBM='mpv https://playerservices.streamtheworld.com/api/livestream-redirect/WBBMAM.mp3'
alias WRCT='mpv ~/Music/WRCT.m3u'
alias WUIS='mpv http://war.str3am.com:7780/wuis.mp3'
alias LTV='mpv https://loosed.tv/live/stream/index.m3u8'
alias punk0='mpv http://149.56.155.73:8080/;'
alias punk1='mpv http://radio.punkrockdemo.com:8000/;'

#** Scrot utility
alias oms='maim -st 9999999 | convert - \( +clone -background black -shadow 50x3+0+0 \) +swap -background none -layers merge +repage $(date +%s).png && omsse'

#** Animated terminal screensaver
# Requires github cli
alias ss='gh screensaver -sstarfield -- --density=1000 --speed=10'

#* Nautilus (Linux File Manager)
# Open file browser in directory
alias here='xdg-open .'

kitty_theme() {
  kitty @ set-colors --all --configured ~/themes/$1.conf
}

