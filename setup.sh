#!/data/data/com.termux/files/usr/bin/bash

install_package() { pkg install -y $1 || { echo "Failed to install $1. Please check for errors and try again."; exit 1; } } 

configure_zshrc() { 
  [ -f ~/.zshrc ] && echo "\n# Changes added by script" >> ~/.zshrc || echo ".zshrc not found. Creating a new one..." 
  echo "export DISPLAY=:1" >> ~/.zshrc
  echo "alias py='python3'" >> ~/.zshrc
  echo "alias py2='python2'" >> ~/.zshrc
  echo "alias startvnc='vncserver && startxfce4 -d :1 &'" >> ~/.zshrc
  echo "alias killvnc='vncserver -kill :1'" >> ~/.zshrc
  rm /data/data/com.termux/files/usr/etc/motd
  echo 'ALIASES:\
 ==================================\
 | vncstart = starts VNC |\
 | killvnc = Ill let you guess |\
 | py = python 3 |\
 | py2 = python 2 |\
 | pki = pkg install |\
 | pku = pkg update |\
 | pkr = pkg remove |\
 | pkau = pkg autoclean |\
 ================================== ' >> /data/data/com.termux/files/usr/etc/motd
}

change_termux_repos() {
  select_repository() {
    if [ "$1" == "Default repositories" ]; then
      echo "[*] Termux primary host (USA) selected"
      MAIN="https://packages.termux.org/apt/termux-main"
      ROOT="https://packages.termux.org/apt/termux-root"
      X11="https://packages.termux.org/apt/termux-x11"
    fi 
    replace_repository sources.list $MAIN "stable main" "$2" "Main repository"
    replace_repository sources.list.d/root.list $ROOT "root stable" "$2" "Root repository"
    replace_repository sources.list.d/x11.list $X11 "x11 main" "$2" "X11 repository"
  }

  replace_repository() {
    if [[ "$4" == *"$5"* ]]; then
      SOURCE_FILE="$1"
      NEW_URL="$2"
      COMPONENT_SUITE="$3"
      TMPFILE="$(mktemp $TMPDIR/$(basename ${SOURCE_FILE}).XXXXXX)"
      if [ "$1" == "sources.list" ]; then echo "# The main termux repository:" >> "$TMPFILE"; fi
      echo "deb ${NEW_URL} ${COMPONENT_SUITE}" >> "$TMPFILE"
      echo "  Changing ${5,,}" 
      mv "$TMPFILE" "/data/data/com.termux/files/usr/etc/apt/${SOURCE_FILE}"
    fi
  }

  TEMPFILE="$(mktemp /data/data/com.termux/files/usr/tmp/mirror.XXXXXX)"
  REPOSITORIES=()
  REPOSITORIES+=("Main repository" "termux-packages" "on")
  [ -f "/data/data/com.termux/files/usr/etc/apt/sources.list.d/root.list" ] && REPOSITORIES+=("Root repository" "termux-root-packages" "off")
  [ -f "/data/data/com.termux/files/usr/etc/apt/sources.list.d/x11.list" ] && REPOSITORIES+=("X11 repository" "x11-packages" "off")
  dialog --clear --checklist "Which repos do you want to edit? Select with space." 0 0 0 "${REPOSITORIES[@]}" --and-widget --clear --radiolist "Which mirror do you want to use?" 0 0 0 "Default repositories" "Default host" on "Default repositories (CF)" "Default host with CloudFlare endpoint" off 2> "$TEMPFILE"
  retval=$?
  clear
  case $retval in 0) IFS=$'\t' read REPOSITORIES MIRROR <<< "$(more $TEMPFILE)"; select_repository "$MIRROR" "$REPOSITORIES";; 1) exit;; 255) exit;; esac
  rm "$TEMPFILE"
  echo "[*] Running apt update"
  apt update
}

if [ -d "/data/data/com.termux/files/home/storage" ]; then
	cat <<- EOF

	It appears that directory '~/storage' already exists.
	This script is going to rebuild its structure from
	scratch, wiping all dangling files. The actual storage
	content IS NOT going to be deleted.

	EOF
	read -re -p "Do you want to continue? (y/n) " CHOICE

	if ! [[ "${CHOICE}" =~ (Y|y) ]]; then
		echo "Aborting configuration and leaving directory '~/storage' intact."
		exit 1
	fi
fi

case "${TERMUX__USER_ID:-}" in ''|*[!0-9]*|0[0-9]*) TERMUX__USER_ID=0;; esac

am broadcast --user "$TERMUX__USER_ID" \
		 --es com.termux.app.reload_style storage \
		 -a com.termux.app.reload_style com.termux > /dev/null
echo "Storage has been set up and is accessible at ~/storage."

read -p "Change the default Termux repositories now? (y/n) " -n 1 -r; echo 
[[ $REPLY =~ ^[Yy]$ ]] && change_termux_repos
install_package tur-repo 
install_package x11-repo
pkg update && pkg upgrade -y 
install_package git
install_package mc
install_package synaptic
install_package code-oss 
install_package tilde 
install_package nodejs 
install_package xfce4 
install_package xfce4-goodies
install_package tigervnc
install_package zsh
install_package python3 
install_package python-pip 
install_package python2
install_package chromium
install_package man
install_package htop
read -p "Switch your default shell to zsh? (y/n) " -n 1 -r; echo 
[[ $REPLY =~ ^[Yy]$ ]] && { configure_zshrc; chsh -s zsh; } 
echo "All done! Changes made:"
echo "- Termux repos updated (if you chose to)"
echo "- Installed tur, x11, git, code-oss, tilde (a way cooler nano), nodejs, xfce4, goodies, tigervnc, zsh, python3 (with pip), python2, chromium, Midnight Commander, Synaptic Package Manager, manpages, and htop"
echo "- Updated .zshrc (if existed)"
echo "- Switched shell to zsh (if you chose to)"
echo "Reminder: Restart Termux, then run 'vncpasswd' to set a password for your VNC server." 
