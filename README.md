# TermuxSetup
Just a 'lil setup script that takes a fresh install of Termux and installs all of the tools and can't-live-without aliases I use so frequently.

## This setup script does stuff. 
### Here is what it does:
- Installs tur-repo and x11-repo repositories
- Installs the XFCE4 desktop
- Installs Code-OSS (gui)
- Installs Termux API
- Installs Python 3
- Installs Python 2 (for oldass scripts)
- Installs Node Package Manager
- Installs AcodeX Server in NPM (For use with Acode's coderunner plugin in their app)
- Installs a VNC Server **(after restart, you'll need to run 'vncpasswd' to choose a password for the server)**
- Installs Zsh
- Changes default Bash shell to god-tier Zsh goodness

## This script comes with aliases!
Tired of typing in 'python3' evvery time you wanna run a script? Say no more, use these aliases instead:

- py = python3
- py2 = python2
- startvnc = vncserver && startxfce4 -d :1 & *(it turns on VNC server and starts up the desktop)*
- killvnc = vncserver --kill :1 *(Kills the VNC server when you're done with the desktop.* **This is important because if you turn off Termux while VNC server is running, the next time you start the server, it'll bitch about locks on the display!)**


## Use the following command to get it running:
```
curl https://raw.githubusercontent.com/theregoesmyeye/TermuxSetup/main/setup.sh | bash
```
---
