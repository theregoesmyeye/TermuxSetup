#!/data/data/com.termux/files/usr/bin/bash

install_package() { 
  pkg install $1 -y || { echo "Failed to install $1. Please check for errors and try again."; exit 1; }
}

configure_zshrc() {
  [ -f ~/.zshrc ] && echo "\n# Changes added by script" >> ~/.zshrc || echo ".zshrc not found. Creating a new one..." 
  echo "export DISPLAY=:1" >> ~/.zshrc
  echo "alias py='python3'" >> ~/.zshrc
  echo "alias py2='python2'" >> ~/.zshrc
  echo "alias startvnc='vncserver && startxfce4 -d :1 &'" >> ~/.zshrc
  echo "alias killvnc='vncserver --kill :1'" >> ~/.zshrc
}

unattended=false
while [[ $# -gt 0 ]]; do
  case $1 in --unattended) unattended=true ;; esac; shift
done

if ! $unattended; then
  install_package tur-repo
  install_package x11-repo
  pkg update && pkg upgrade -y 
  install_package code-oss
  install_package npm
  npm install -g acodex-server 
  install_package xfce4 
  install_package xfce4-goodies
  install_package tigervncserver 
  install_package zsh
  read -p "Do you want to switch your default shell to zsh? (y/n) " -n 1 -r; echo 
  [[ $REPLY =~ ^[Yy]$ ]] && { configure_zshrc; chsh -s zsh; }
else 
  pkg install tur-repo x11-repo -y 
  pkg update && pkg upgrade -y 
  pkg install code-oss npm xfce4 xfce4-goodies tigervncserver zsh -y 
  npm install -g acodex-server 
  configure_zshrc
  chsh -s zsh 
fi

echo "All done! Restart Termux for changes to fully take effect." 
echo "Remember to install and set up a VNC viewer to use XFCE."
