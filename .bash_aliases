
#Youtube DL MP4
alias ydl=youtube-dl

alias youtube-dl-mp4='youtube-dl -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4"'
alias ydl-mp4=youtube-dl-mp4

#Youtube DL MP3
alias youtube-dl-mp3='youtube-dl --extract-audio --audio-format mp3'
alias ydl-mp3=youtube-dl-mp3

#Manjaro Firefox Problems
alias firefox-home-reset='sudo sed -i "s|https://manjaro.org/|about:home|1" /usr/lib/firefox/distribution/distribution.ini'

# Get weather
alias weather="curl wttr.in"

#VS Code
alias vscode=code

#Keybindings
alias bind-esc='setxkbmap -option caps:escape'
alias unbind-esc='setxkbmap -option'

#Yay update
alias yayay="yay -Syu --noconfirm && firefox-home-reset && cleanup"

#Save windows and poweroff
alias poweroff="lwsm save; poweroff"

#XClip to default to clipboard selection
alias xclip="xclip -selection clipboard"

export BIGFOOT_SERVER="scleong@bigfoot.apt.ri.cmu.edu -p 2002"
#alias harp="ssh scleong@bigfoot.apt.ri.cmu.edu -p 2002"
alias harp="ssh bigfoot"
alias harptensor="ssh -NfL 6006:localhost:6006 bigfoot; firefox localhost:6006"
alias researchcode="goto researchcode && code ."

export ANDREW_LINUX=scleong@linux.andrew.cmu.edu
alias sshandrew="sshpass -p $(gpg -d -q ~/.ssh/.andrewpwd.gpg) ssh -X $ANDREW_LINUX"

alias cleanup="sudo pacman -Sc --noconfirm; sudo find ~/ -type f -name .fifo_temp -exec rm {} \;"
alias activatevol="pyenv activate vol"; alias pyactivate=activatevol