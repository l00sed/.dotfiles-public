#!/bin/bash

#BEGIN - Table of Contents ====================================

   #  Personal SSH aliases
      #  Linux modules reload (Sound still requires restart)

#END   - Table of Contents ====================================

#* Personal SSH aliases
alias loosed="ssh loosed"
alias loosedtv='ssh dan@loosed.tv'
alias loosedstore='ssh dan@loosed.store'
alias dato='ssh dan@dato.work'
alias home='cd $HOME'

#** Linux modules reload (Sound still requires restart)
alias fixWIFI='sudo dpkg -i /home/dan/Downloads/fixWIFI/bcmwl-kernel-source_6.30.223.271+bdcom-0ubuntu5_amd64.deb'
#alias fixWIFI='sudo apt-get install --reinstall --upgrade bcmwl-kernel-source'
alias fixSOUND='sudo pulseaudio -k && alsa force-reload'
