#!/bin/bash
#BEGIN - Table of Contents ====================================

   #  Android Studio

#END   - Table of Contents ====================================
#* Android Studio
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
alias emulatorUp='adb start-server && $ANDROID_HOME/emulator/emulator @Nexus_5_API_28'
