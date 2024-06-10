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
1. Now sets up storage and installs git, bruh.
**Jun 9th:** I made a custom handycolorful zsh prompt:
![screenshot](https://github.com/theregoesmyeye/TermuxSetup/blob/main/IMG_20240609_211518.jpg)
The number on the left before the clock is your history number. Need to repeat commands? Remember your history number from my new prompt, and when you have to repeat a command for the second time in a session, simply type "!(history number)". **NOTE:** If you've already installed my script once already but still want this prompt, you may have it by typing in: 
```
echo "PROMPT='%F{magenta}╭─%! - %t %F{yellow}[%F{white}%~%F{yellow}]%f %F{magenta}╰─$%F{cyan} '" >> ~/.zshrc
```

Restart Termux and the prompt is yours!