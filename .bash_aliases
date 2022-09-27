#Youtube DL MP4
alias ydl=youtube-dl

alias youtube-dl-mp4='youtube-dl -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4"'
alias ydl-mp4=youtube-dl-mp4

# Youtube DL MP3
alias youtube-dl-mp3='youtube-dl --extract-audio --audio-format mp3'
alias ydl-mp3=youtube-dl-mp3

# Manjaro Firefox Problems
alias firefox-home-reset='sudo sed -i "s|https://manjaro.org/|about:home|1" /usr/lib/firefox/distribution/distribution.ini'

# Opening folder/files
alias explorer=xdg-open
alias open=xdg-open

# Get weather
alias weather="curl wttr.in"

#VS Code
alias vscode=code

#Keybindings
alias bind-esc='setxkbmap -option caps:escape'
alias unbind-esc='setxkbmap -option'

#Yay update
alias yayay="yay -Syu --noconfirm" # && firefox-home-reset" && cleanup"
alias listupdate="pacman -Qu | awk '{ print \$1 }'"
alias list-update=listupdate

#Save windows and poweroff
alias poweroff="lwsm save; poweroff"

#XClip to default to clipboard selection
alias xclip="xclip -selection clipboard"

export BIGFOOT_SERVER="scleong@bigfoot.apt.ri.cmu.edu -p 2002"
alias harp="ssh bigfoot"
alias harpvisual="ssh -X bigfootvisual"
alias harpvis=harpvisual
alias researchcode="goto researchcode && git pull && code ."

alias cvcode="goto cvcode && code ."

export ANDREW_LINUX=scleong@linux.andrew.cmu.edu
alias sshandrew="sshpass -p $(gpg -d -q ~/.ssh/.andrewpwd.gpg) ssh -X $ANDREW_LINUX"

export ANDREW_SHARK=scleong@angelshark.ics.cs.cmu.edu
export ANDREW_SHARK_2=scleong@catshark.ics.cs.cmu.edu

alias shark="sshpass -p $(gpg -d -q ~/.ssh/.andrewpwd.gpg) ssh -X $ANDREW_SHARK"
alias shark2="sshpass -p $(gpg -d -q ~/.ssh/.andrewpwd.gpg) ssh -X $ANDREW_SHARK_2"

export ECE_SERVER=scleong@ece007.ece.local.cmu.edu

alias cleanup="yay -Sc --noconfirm; sudo pacman -Sc --noconfirm; sudo find ~/ -type f -name .fifo_temp -exec rm {} \;"
alias activatevol="pyenv activate vol"
alias pyactivate=activatevol

# Quartus Stuff
alias fixjtag="killall jtagd; jtagd; jtagconfig"

# NVIDIA Fixes
alias nvidia-fix="sudo rm /etc/X11/xorg.conf; echo 'Removed xorg config'"
alias gpureload="sudo rmmod nvidia_uvm ; sudo modprobe nvidia_uvm"

alias cups="sudo systemctl restart cups.service"

alias bumblebee="sudo systemctl enable --now bumblebeed"

# School stuff
alias doxy="doxygen && gitpush 'Update doxygen documentation'"

# alias mobilehw="goto mobilehw; firefox HW_22*.pdf; open *.tex"
# alias robohw=mobilehw

alias 642code="goto turtle; code ."
alias vlcode="goto vlcode; code ."

alias ivweb="goto ivweb; code ."

# GCP stuff
export GCP_MAIN_INSTANCE=vl-gpu-single
alias gcp="gcloud compute"
alias gcpstart="gcp instances start $GCP_MAIN_INSTANCE"
alias gcpstop="gcp instances stop $GCP_MAIN_INSTANCE"
alias sshgcp="gcp ssh --zone us-east1-c --project universal-chain-362420 $GCP_MAIN_INSTANCE"

gscp(){
    gcloud compute scp --project universal-chain-362420 $1 $GCP_MAIN_INSTANCE:$2
}