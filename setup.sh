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
Tired of typing in 'python3' every time you wanna run a script? Say no more, use these aliases instead:

- py = python3
- py2 = python2
- startvnc = vncserver && startxfce4 -d :1 & *(it turns on VNC server and starts up the desktop)*
- killvnc = vncserver --kill :1 *(Kills the VNC server when you're done with the desktop.* **This is important because if you turn off Termux while VNC server is running, the next time you start the server, it'll bitch about locks on the display!)**


## Use the following command to get it running:
```
curl https://raw.githubusercontent.com/theregoesmyeye/TermuxSetup/main/setup.sh | bash
```
---
# TermuxSetup

Yeah, yeah, another setup script. This one does the usual boring stuff, but hey, this one is recently updated (probably) and it actually works (also probably).

## What This Script (Begrudgingly) Does

* **Updates Your Repos (Because It Has To):**  Gets you the freshest packages because apparently that's important to some people.
* **Installs Essential Repos:** Adds tur-repo and x11-repo, because who doesn't need more package sources?
* **Development Tools (Blah Blah Blah):** Installs Code-OSS (for the GUI lovers), Nodejs (with npm, of course), Python 3 (with pip), Python 2 (for the dinosaurs), and more. 
* **XFCE4 Desktop (If You're Into That Sort of Thing):** Sets up XFCE4 so you can pretend Termux is a real computer.
* **VNC Server (With a Catch):** Installs a VNC server so you can remotely access your tiny Android desktop.  **Don't forget:**  Run `vncpasswd` after restarting to actually set a password.
* **Zsh Upgrade (Because Bash Is Lame):** Switches your default shell to the mighty Zsh.
* **Aliases (For the Extremely Lazy):**  Includes these shortcuts so you don't have to type a few extra characters:
    * `py` - Run Python 3 scripts
    * `py2` - Run Python 2 scripts
    * `startvnc` - Start the VNC server and XFCE4 desktop
    * `killvnc` - Stop the VNC server (Srsly: this is important because if you do not kill the server before stopping Termux, the next time you use startvnc, it'll bitch about display locks.)

## Usage (If You Must)

**Here is an overly-complicated one-liner to install so I can look as though I'm smart and I know what I'm doing:**
```
curl https://raw.githubusercontent.com/theregoesmyeye/TermuxSetup/main/setup.sh | tee ~/setup.sh && chmod +x ~/setup.sh && bash ~/setup.sh && rm ~/setup.sh
```

# Changes:

1. Now sets up storage and also installs git.