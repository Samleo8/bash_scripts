# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/dee/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
*) ;;

esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# Path settings
export CUDA_HOME=/opt/cuda
export CUDA_PATH=$CUDA_HOME:$CUDA_HOME/bin

export ANDROID_HOME=/home/sam/Android/Sdk
export JAVA_HOME=/usr/bin/java

export LD_LIBRARY_PATH=$CUDA_HOME/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
# export CUDA_VISIBLE_DEVICES=0

export WEBOTS_HOME=/usr/local/webots
export LD_LIBRARY_PATH=${WEBOTS_HOME}/lib/controller${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

export ANDROID_PATH=$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME:${PATH}:$JAVA_HOME

export NODE_PATH=/usr/local/lib/node_modules/node/bin/

export EIGEN_INCLUDE_DIRS=/usr/include/eigen3
PATH="$NODE_PATH:$PATH:$EIGEN_INCLUDE_DIRS:$CUDA_PATH"

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib/pkgconfig

export PYTHONPATH=${PYTHONPATH}:/usr/local/python
export PYTHON_SITE_PKG=/home/sam/.local/lib/python3.10/site-packages

source /etc/profile.d/vte.sh

export RUBY_PATH="/home/sam/.gem/ruby/3.0.0/bin"
export GEM_PATH=$RUBY_PATH
export PATH="$RUBY_PATH:$PATH"

###=====================KEYBOARD SETTINGS=====================###
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Control><Shift><Alt>Left', '<Control><Shift><Alt>Up', '<Primary><Shift><Alt>Left']"

# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['<Control><Shift><Alt>Left', '<Control><Shift><Alt>Up', '<Primary><Shift><Alt>Left']"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control><Alt>Left', '<Control><Alt>Up', '<Primary><Alt>Left']"

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Control><Shift><Alt>Right', '<Control><Shift><Alt>Down', '<Primary><Shift><Alt>Right']"

# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['<Control><Shift><Alt>Right', '<Control><Shift><Alt>Down', '<Primary><Shift><Alt>Right']"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control><Alt>Right', '<Control><Alt>Down', '<Primary><Alt>Right']"

gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ next-tab '<Primary>Tab'

gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ prev-tab '<Primary><Shift>Tab'

###=====================SHORTCUT FUNCTIONS=====================###
#cd and then ls
cdls() {
	cd "$1" && l -a
}

alias cdl=cdls

#Git
gitpush() {
	git add .
	git commit -m "$1"
	git push
}

export -f gitpush

gitadd() {
	TOADD="${@:1:$#-1}"
	TOCOMMIT="${!#}" # get last element

	git add $TOADD
	git commit -m "$TOCOMMIT"
}

export -f gitadd

#Process handling
alias showproc=htop

findproc() {
	ps -e | grep -i "$1"
}

killproc() {
	kill $(ps -e -o pid,cmd | grep -i '$1' | grep -Po '^[0-9]+|^.*?\K[0-9]+')
}

#Echo functions with fancy colours
echo_colour() {
	echo -e "$(tput setaf $2)$1$(tput sgr0)"
}

alias echo_color=echo_colour

echo_err() {
	echo_colour "$1" 1 #red
}

echo_ok() {
	echo_colour "$1" 82 #green
}

echo_orange() {
	echo_colour "$1" 172
}

echo_blue() {
	echo_colour "$1" 81
}

export -f echo_err
export -f echo_colour
export -f echo_ok
export -f echo_orange
export -f echo_blue

# Extractor
# # usage: ex <file>
ex_single() {
	if [ -f $1 ]; then
		case $1 in
		*.tar.bz2) tar xjf $1 ;;
		*.tar.gz) tar xzf $1 ;;
		*.bz2) bunzip2 $1 ;;
		*.rar) unrar x $1 ;;
		*.gz) gunzip $1 ;;
		*.tar) tar xf $1 ;;
		*.tbz2) tar xjf $1 ;;
		*.tgz) tar xzf $1 ;;
		*.zip) unzip $1 ;;
		*.Z) uncompress $1 ;;
		*.7z) 7z x $1 ;;
		*) echo "'$1' cannot be extracted via ex()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

ex() {
	for file in $@; do
		ex_single $file
	done
}

alias extract=ex
alias exall=ex

#OpenCV compile
compilecv() {
	echo "Compiling $1.cpp..."
	g++ "$1.cpp" -o "$1" $(pkg-config --cflags --libs opencv) && {
		echo "$1.cpp succesfully compiled as ./$1"
	} || {

		echo "Compilation failed."
	}
}

export -f compilecv

#Java Compile and Run
javar() {
	echo "Compiling $1.java..."
	javac Hello.java && {
		echo "Compilation Successful! Running $1"
		java $1
	} || {
		"Compilation failed."
	}
}

# C compile and run
compilec() {
	# In case wanna add flags
	FLAGS="-g"
	# FLAGS="-Wall -g"
	FILENAME=$1 # ${@:$#}
	if [ -f "$FILENAME.c" ]; then
		gcc $FLAGS $@.c -o "$FILENAME.out" && ./"$FILENAME.out"
	elif [ -f "$FILENAME" ]; then
		gcc $FLAGS $@ -o "$FILENAME.out" && ./"$FILENAME.out"
	else
		echo_err "Cannot compile and run $FILENAME: Does not exist"
	fi
}

export -f compilec

alias ccompile=compilec
alias gcccompile=compilec

# Special goto function (cd to special directories)
goto() {
	if [[ -z "$1" ]]; then
		cd ./
	fi

	case $1 in
	"cmu")
		cd ~/CMU
		;;
	"study")
		cd ~/CMU/Study
		;;
	"cmuresearch")
		cd ~/CMU/Research/
		;;
	"learnable" | "3dpose")
		cd "/home/sam/CMU/Research/3D Pose HARP/Code/learnable-triangulation-pytorch"
		;;
	"klt")
		cd "/home/sam/CVPlayground/KLTCpp"
		cd $(cat .active_code_dir)
		;;
	"radar" | "sar")
		goto dso
		cd DSOPulseChirpSim
		git pull
		;;
	"odom" | "cfear")
		goto dso
		cd "3D Radar Odometry/CFEAR"
		git pull
		;;
	"TOF" | "tof")
		cd "/home/sam/CMU/Research/CMU CV Radar/TOF"
		;;
	"radarsim")
		cd "/home/sam/CMU/Research/CMU CV Radar/simulation"
		;;
	"radarraw" | "rawradar" | "radardata")
		cd "/home/sam/CMU/Research/CMU CV Radar/rawdata"
		git pull
		;;
	"surf")
		cd "/home/sam/CMU/Research/CMU CV Radar/SURFProposalRadar"
		git pull
		;;
	"dso")
		cd "/home/sam/DSO"
		;;
	"sisyphus")
		cd ~/Documents/MobileApps/SisyphusSheep
		;;
	"telegram")
		cd ~/Documents/Telegram\ Bots/
		;;
	"biblequizzle" | "quizzle")
		cd ~/Documents/Telegram\ Bots/BibleQuizzle
		;;
	"quizzlediscord")
		cd ~/Documents/Discord\ Bots/BibleQuizzleDiscord
		;;
	"unreal" | "ut" | "ut2004")
		cd ~/Downloads/ut2004
		./runGame
		cd -
		;;
	"pinball")
		cd ~/Downloads/pinball
		wine pinball.exe
		;;
	"website" | "github")
		cd ~/Documents/Github\ Website
		;;
	"resume")
		cd "/home/sam/Documents/Github Website/resumecv"
		;;
	"iv" | "IV" | "ivcf" | "IVCF")
		cd "/home/sam/CMU/IVCF"
		;;
	"alpha")
		cd "/home/sam/CMU/IVCF/Alpha"
		;;
	"ivlyrics")
		cd "/home/sam/CMU/IVCF/LG/lyrics"
		;;
	"ivwebsite" | "ivweb")
		cd "/home/sam/CMU/IVCF/website"
		;;
	"linear" | "systems" | "18771" | "controls")
		cd "/home/sam/CMU/Study/18771 Linear Systems"
		;;
	"ml" | "18848" | "848" | "dl" | "embedded" | "embed")
		cd "/home/sam/CMU/Study/18848 Embedded Deep Learning"
		;;
	"mlhw" | "dlhw" | "18848hw" | "848hw" | "embedhw" | "embeddedhw")
		goto ml
		cd homework
		cd $(cat .active_hw_dir)
		;;
	"mlcode")
		goto mlhw
		cd code
		;;
	"safe" | "safety" | "16883" | "883" | "robo" | "robotics")
		cd "/home/sam/CMU/Study/16883 Provably Safe Robotics"
		;;
	"optim" | "optimization" | "optimisation" | "18660" | "660")
		cd "/home/sam/CMU/Study/18660 Optimization"
		;;
	"optimhw" | "optimizationhw" | "optimisationhw" | "18660hw" | "660hw")
		goto optim
		cd homework
		cd $(cat .active_hw_dir)
		;;
	*)
		cd "$1" || cd ~/"$1"
		;;
	esac
}

export -f goto

# Sync 240 folder with Github (because ECE servers no Internet connection)
240sync() {
	if [[ ! -z "$1" ]]; then
		goto 240
		cd labs
		gitpush "$1"
		echo -e "Synced shared lab side\n"

		goto 240
		git add ./labs
		git commit -m"Update labs $1"
		gitpush "$1"
		cd -
		echo -e "Synced global side\n"
	fi

	echo -e "\nSyncing with Andrew servers... "
	sshpass -p $(gpg -d -q ~/.ssh/.andrewpwd.gpg) ssh $ANDREW_LINUX 'cd ~/private/18240 && git pull && cd ~/private/18240/labs && git pull && echo -e "Success!\n" || echo -e  "Failure!\n"; git add --all . && git commit -m"Update from server (labs)" && git push; cd ~/private/18240 && git add --all . && git commit -m"Update from server (global)" && git push && exit'

	# Sync locally
	echo -e "\nSyncing locally... "
	goto 240 && git pull && cd - && echo "Success!" || echo "Failure!"

	echo "Syncing labs..."
	goto 240 && cd labs && git pull && cd - && echo "Success!" || echo "Failure!"
}

# Open embedded lab stuff
embedrun() {
	goto embedlab
	gnome-terminal -- bash -c "./linux_ocd; bash"
	gnome-terminal -- bash -c "minicom; bash"

	make flash $@
}

# Update all instances of sammath
updatesammath() {
	MSG=${1:-("Update sammath")}

	find ~/CMU/Study -inum 3300840 -print0 |
		while IFS= read -r -d '' file; do
			DIR=$(dirname "$file")
			cd "$DIR"
			LOCALFILE=$(basename "$file")

			echo $DIR
			git add $LOCALFILE
			git commit -m "$MSG"
			git push
			echo -e "Done.\n"
		done
}

# Update BibleQuizzle leaderboard
updatequizzle() {
	MSG=${1:-("Update leaderboard")}

	goto quizzle

	gedit leaderboard.json &&
		git add leaderboard.json &&
		git commit -m "$MSG" &&
		git push
}

# Update BibleQuizzle leaderboard
updatequizzlediscord() {
	MSG=${1:-("Update leaderboard")}

	goto quizzlediscord

	gedit leaderboard.json &&
		git add leaderboard.json &&
		git commit -m "$MSG" &&
		git push
}

# Research stuff
harptensor() {
	if [ -z "$1" ]; then
		TENSORBOARD_PORT=6006
	else
		TENSORBOARD_PORT=$1
	fi

	ssh -NfL $TENSORBOARD_PORT:localhost:$TENSORBOARD_PORT bigfoot
	firefox localhost:$TENSORBOARD_PORT
}

export -f harptensor

# Save scripts in bash_scripts folder
savescripts() {
	FOLDER_DIR=/home/sam/bash_scripts/

	if (($# < 2)); then
		echo "USAGE: savescripts <scripts_to_save ..> <commit_message>"
		return
	fi

	MESSAGE=${@:$#}  # last parameter
	FILES=${*%${!#}} # all parameters except the last

	cp $FILES $FOLDER_DIR
	cd $FOLDER_DIR
	gitpush "$MESSAGE"
	cd -
}

# Split PDFs into individual pages
splitpdf() {
	if [[ -z "$1" ]]; then
		echo "USAGE: splitpdf <file.pdf>"
		echo "NOTE: Creates new folder called <file>"
		return
	fi

	filename="$1"
	filename=${filename%.*}
	mkdir $filename
	pdftk "$filename.pdf" burst output "$filename/$filename-%d.pdf"
}

# Create blank page
createBlankPDF() {
	numberOfPages=${1:-1}
	echo '\documentclass{article}' >blank.tex
	echo '\usepackage{pdfpages}' >>blank.tex
	echo '\begin{document}' >>blank.tex
	for ((i = 1; i <= $numberOfPages; i++)); do
		echo '\newpage\null\thispagestyle{empty}\newpage'
	done >>blank.tex
	echo '\end{document}' >>blank.tex

	: | pdflatex -halt-on-error blank.tex | grep '^!.*' -A200 --color=always

	# Keep only the pdf
	rm blank.{tex,out,log,aux,bbl,blg,dvi,toc,synctex.gz} >/dev/null 2>&1

	echo "blank.pdf created with $numberOfPages blank page(s)"
}

export -f createBlankPDF

# PDF TO BOOKLET
pdf2book() {
	USAGE_STR="Usage: pdf2book <filename[.pdf]> [-c:crop] [-l:US letter size] [-h:help]"
	CROP_OPT=""
	FILE_SUFFIX="booklet"
	PAPER_TYPE="a4paper"

	while getopts ":hcl" opt; do
		case $opt in
		c)
			CROP_OPT="--trim '1cm 1cm 1cm 1cm' --clip 'true'"
			FILE_SUFFIX="cropped-$FILE_SUFFIX"
			;;
		l)
			PAPER_TYPE="letter"
			FILE_SUFFIX="$FILE_SUFFIX-letter"
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			;&
		h)
			echo $USAGE_STR
			return
			;;
		esac
	done

	if [[ -z "$1" ]]; then
		echo -e $USAGE_STR
		return
	fi

	FILE=$(echo $1 | sed 's/.pdf//')

	if [ ! -f "$FILE.pdf" ]; then
		echo "File $FILE.pdf not found."
		echo -e "$USAGE_STR"
		return
	fi

	PAGES=$(pdftk "$FILE.pdf" dump_data | grep NumberOfPages | awk '{print $2}')
	echo -e "Converting '$FILE.pdf' of $PAGES page(s)...\n"

	CMD="pdfjam --booklet 'true' --signature $PAGES --landscape --suffix '$FILE_SUFFIX' --paper '$PAPER_TYPE' $CROP_OPT --quiet -- '$FILE.pdf'"

	echo -e "$ $CMD\n"
	eval $CMD

	echo "Booklet saved: $FILE-$FILE_SUFFIX.pdf"
}

alias pdf2booklet=pdf2book
export -f pdf2book

# PDF TO JPG
pdf2jpg() {
	if [[ -z "$1" ]]; then
		echo "USAGE: pdf2jpg <file.pdf>"
		return
	fi

	PDF=$1

	echo "Processing $PDF"
	DIR=$(basename "$1" .pdf)

	mkdir "$DIR"

	echo '  Splitting PDF file to pages...'
	pdftk "$PDF" burst output "$DIR"/%04d.pdf
	pdftk "$PDF" dump_data output "$DIR"/metadata.txt

	echo '  Converting pages to JPEG files...'
	for i in "$DIR"/*.pdf; do
		convert -colorspace RGB -interlace none -density 300x300 -quality 100 "$i" "$DIR"/$(basename "$i" .pdf).jpg
	done

	rm "$DIR"/*.pdf
	rm "$DIR"/*.txt

	echo 'All done'
}

alias pdf2img=pdf2jpg
export -f pdf2jpg

img2pdf() {
	if (($# < 2)); then
		echo "USAGE: img2pdf <images ..> <output>"
		return
	fi

	IMAGES=${@:1:$#-1}
	OUTPUT="${!#}" # get last element

	echo "Combining $IMAGES into $OUTPUT..."

	convert ${IMAGES} -quality 100 "$OUTPUT"

	echo "Done!"
}

export -f img2pdf

# Compress video using ffmpeg
compress-video() {
	if [ -z $2 ]; then
		COMPRESS_RATE=24
	else
		COMPRESS_RATE=$2
	fi

	FILENAME=$1
	if [ -f "$FILENAME" ]; then
		FILENAME="${FILENAME%.*}"
	elif [ -f "$FILENAME.mp4" ]; then
		FILENAME="$1"
	else
		echo "ERROR: File $FILENAME does not exist"
		echo "USAGE: $ compress-video <video-name.mp4> [compress-rate (def: 32)]"
		return 1
	fi

	ffmpeg -i "$1" -vcodec libx265 -crf $COMPRESS_RATE "$FILENAME-compressed.mp4"
}

export -f compress-video

# Convert video to gif file.
# Usage: mp4togif video_file (scale) (fps)
mp4togif() {
	FILENAME=$1
	if [ -f "$FILENAME" ]; then
		FILENAME="${FILENAME%.*}"
	elif [ -f "$FILENAME.mp4" ]; then
		FILENAME="$1"
	else
		echo "File $FILENAME does not exist"
		echo "USAGE: $ mp4togif <video_file> (scale) (fps)"
		return 1
	fi

	SCALE=${2:-320}
	FPS=${3:-10}

	ffmpeg -i ${FILENAME}.mp4 -vf "fps=$FPS,scale=$SCALE:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 ${FILENAME}.gif

	# ffmpeg -y -i "${FILENAME}.mp4" -vf fps=${3:-10},scale=${2:-320}:-1:flags=lanczos,palettegen
	# ffmpeg -i "${FILENAME}.mp4" -i "${FILENAME}.png" -filter_complex "fps=${3:-10},scale=${2:-320}:-1:flags=lanczos[x];[x][1:v]paletteuse" "${FILENAME}".gif
}

# Display all upgradable packages in a single line
toinstall(){
	yay -Qu | awk '{ print $1 }' ORS=' '
	echo ""
}

alias upgradable=toinstall

# Programming handin function
sshshark() {
	if [ -z $1 ]; then
		SHARK_URL=$ANDREW_SHARK
	else
		SHARK_URL="scleong@$1shark.ics.cs.cmu.edu"
	fi

	sshpass -p $(gpg -d -q ~/.ssh/.andrewpwd.gpg) ssh -X $SHARK_URL
}

sshece() {
	if [ -z $1 ]; then
		ECE_URL=$ECE_SERVER
	else
		ECE_URL="scleong@ece$1.ece.local.cmu.edu"
	fi

	sshpass -p $(gpg -d -q ~/.ssh/.andrewpwd.gpg) ssh -X $ECE_URL
}

122lab() {
	sshpass -p $(gpg -d -q ~/.ssh/.andrewpwd.gpg) ssh -X $ANDREW_LINUX '/afs/andrew/course/15/122/bin/122lab'
	exit
}

handin() {
	FOLDER_NAME=${PWD##*/}
	BASE_DIRECTORY="~/private/18213"
	COPY_TO="$ANDREW_LINUX:$BASE_DIRECTORY/$FOLDER_NAME"

	gpg -d -q ~/.ssh/.andrewpwd.gpg >.fifo_temp

	sshpass -f .fifo_temp ssh $ANDREW_LINUX 'cd '$BASE_DIRECTORY' && mkdir -p '$FOLDER_NAME

	tar -czvf handin.tar ${@:2} &&
		sshpass -f .fifo_temp scp ./handin.tar $COPY_TO &&
		sshpass -f .fifo_temp ssh $ANDREW_LINUX 'cd '$BASE_DIRECTORY'/'$FOLDER_NAME' && tar -xzvf handin.tgz && yes yes | /afs/andrew/course/15/213/bin/handin '$@' && echo "Complete"'

	rm ./.fifo_temp
	rm ./handin.tar
}

scptoandrew() {
	COPY_TO="$ANDREW_LINUX:$2"

	sshpass -p $(gpg -d -q ~/.ssh/.andrewpwd.gpg) scp $1 $COPY_TO
}

scpfromandrew() {
	COPY_FROM="$ANDREW_LINUX:$1"

	sshpass -p $(gpg -d -q ~/.ssh/.andrewpwd.gpg) scp $COPY_FROM $2
}

export -f scptoandrew
export -f scpfromandrew

scptoece() {
	COPY_TO="$ECE_SERVER:$2"

	sshpass -p $(gpg -d -q ~/.ssh/.andrewpwd.gpg) scp $1 $COPY_TO
}

scpfromece() {
	COPY_FROM="$ECE_SERVER:$1"

	sshpass -p $(gpg -d -q ~/.ssh/.andrewpwd.gpg) scp $COPY_FROM $2
}

export -f scptoandrew
export -f scpfromandrew

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/sam/.sdkman"
[[ -s "/home/sam/.sdkman/bin/sdkman-init.sh" ]] && source "/home/sam/.sdkman/bin/sdkman-init.sh"

# Quartus Paths
# TODO: Remove quartus eventually
# export ALTERAPATH="/home/sam/intelFPGA_lite/20.1"
# export ALTERAOCLSDKROOT="${ALTERAPATH}/hld"
# export QUARTUS_ROOTDIR=${ALTERAPATH}/quartus
# export QUARTUS_ROOTDIR_OVERRIDE="$QUARTUS_ROOTDIR"
# export QSYS_ROOTDIR="${ALTERAPATH}/quartus/sopc_builder/bin"
# export PATH=$PATH:${ALTERAPATH}/quartus/bin
# export PATH=$PATH:${ALTERAPATH}/nios2eds/bin

# Nvidia Fixes
graphicx() {
	sudo xgraphic $1
	nvidia-fix
}

# MatLab cmd
matcmd() {
	# "functionname(argument1, argument2, argumentN);exit"
	if [[ -z "$1" ]]; then
		echo "USAGE: matcmd <functionname> [argument1 [argument2 ... [argumentN]]"
		return
	fi

	MAT_STR=""
	PREPEND=""
	APPEND=""
	i=0
	for ARG in "$@"; do
		if [[ $i == 0 ]]; then
			PREPEND=""
			APPEND="("
		elif [[ $i == 1 ]]; then
			PREPEND=""
			APPEND=""
		else
			PREPEND=", "
		fi

		MAT_STR="$MAT_STR$PREPEND$ARG$APPEND"

		((i++))
	done

	MAT_STR="$MAT_STR)"
	echo "\$ $MAT_STR"

	matlab -nodesktop -r "$MAT_STR"
}

alias matfn=matcmd
alias matlabcmd="matlab -nodesktop"

sshrobot() {
	HOST=$1
	PASSWORD=$2

	if [ -z "$1" ]; then
		echo "Please key in last 2 digits of host IP"
		return
	fi

	HOST="pi@172.26.229.$HOST"
	sshpass -p $PASSWORD ssh $HOST
}

# PyTorch
# export TORCH_INSTALL_PREFIX=`python -c 'import torch;print(torch.utils.cmake_prefix_path)'`
# export TORCH_HOME=/home/sam/Downloads/libtorch
# export TORCH_INSTALL_PREFIX=$TORCH_HOME
# export TORCHRT_ROOT=/home/sam/.pyenv/versions/3.9.2/envs/capstone/lib/python3.9/site-packages/torch_tensorrt

export PATH=$PATH:$TORCHRT_ROOT/bin
# export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$TORCH_HOME/lib

# Python Virtual Environment
PATH="/home/sam/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# Google Cloud (GCP) Stuff
# All commands in ~/.bash_gcp, instead of adding them here directly.
if [ -f ~/.bash_gcp ]; then
	. ~/.bash_gcp
fi

# AWS Stuff	
# All commands in ~/.bash_aws, instead of adding them here directly.
if [ -f ~/.bash_aws ]; then
	. ~/.bash_aws
fi

