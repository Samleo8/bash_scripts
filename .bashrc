# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/dee/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
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
    xterm-color|*-256color) color_prompt=yes;;
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
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
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
PATH=/usr/local/cuda-10.1/bin${PATH:+:${PATH}}$ 

export ANDROID_HOME=/home/sam/Android/Sdk
export JAVA_HOME=/usr/bin/java

export LD_LIBRARY_PATH=/usr/local/cuda-10.1/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

export ANDROID_PATH=$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME:${PATH}:$JAVA_HOME

export NODE_PATH=/usr/local/lib/node_modules/node/bin/

export EIGEN_INCLUDE_DIRS=/usr/include/eigen3
PATH="$NODE_PATH:$PATH:$EIGEN_INCLUDE_DIRS"

#export PYTHONPATH=${PYTHONPATH}:/usr/local/python

source /etc/profile.d/vte.sh

#Python Virtual Environment
PATH="/home/sam/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export RUBY_PATH="/root/.gem/ruby/2.7.0/bin"
export PATH="$RUBY_PATH:$PATH"

###=====================KEYBOARD SETTINGS=====================###
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['<Control><Shift><Alt>Left', '<Control><Shift><Alt>Up', '<Primary><Shift><Alt>Left']"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Control><Alt>Left', '<Control><Alt>Up', '<Primary><Alt>Left']"

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['<Control><Shift><Alt>Right', '<Control><Shift><Alt>Down', '<Primary><Shift><Alt>Right']"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Control><Alt>Right', '<Control><Alt>Down', '<Primary><Alt>Right']"

gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ next-tab '<Primary>Tab'

gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ prev-tab '<Primary><Shift>Tab'

###=====================SHORTCUT FUNCTIONS=====================###
#cd and then ls
cdls(){
	cd "$1" && l -a
}

alias cdl=cdls

#Git
gitpush(){
	git add .
	git commit -m "$1"
	git push
}

gitadd(){
	TOADD="${@:1:$#-1}"
        TOCOMMIT="${!#}" # get last element

	git add $TOADD;
	git commit -m "$TOCOMMIT"
}

#Process handling
alias showproc=htop

findproc(){
	ps -e | grep -i "$1"
}

killproc(){
	kill `ps -e -o pid,cmd | grep -i '$1' | grep -Po '^[0-9]+|^.*?\K[0-9]+'`
}

#Echo functions with fancy colours
echo_colour(){
	echo -e "$(tput setaf $2)$1$(tput sgr0)"
}

alias echo_color=echo_colour

echo_err(){
	echo_colour "$1" 1 #red
}

echo_ok(){
	echo_colour "$1" 82 #green
}

echo_orange(){
	echo_colour "$1" 172
}

echo_blue(){
	echo_colour "$1" 81
}

export -f echo_err
export -f echo_colour
export -f echo_ok
export -f echo_orange
export -f echo_blue

#OpenCV compile
compilecv(){
	echo "Compiling $1.cpp..."
	g++ "$1.cpp" -o "$1" `pkg-config --cflags --libs opencv` && {
		echo "$1.cpp succesfully compiled as ./$1"
	} || {

		echo "Compilation failed."
	}
}

export -f compilecv

#Java Compile and Run
javar(){
	echo "Compiling $1.java..."
	javac Hello.java && {
		echo "Compilation Successful! Running $1"
		java $1
	} || {
		"Compilation failed."
	}
}

# C compile and run
compilec(){
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

#Special goto function (cd to special directories)
goto(){
	if [[ -z "$1" ]]; then
		cd ./;
	elif [[ "$1" == "cmu" ]]; then
		cd ~/CMU;
	elif [[ "$1" == "study" ]]; then
		cd ~/CMU/Study;
	elif [[ "$1" == "dso" || "$1" == "radar" ]]; then
		cd "/home/sam/CMU/Research/Radar Odometry";
	elif [[ "$1" == "research" ]]; then
		cd "/home/sam/CMU/Research/3D Pose HARP";
		#ssh -NfL 6006:localhost:6006 bigfoot;
	elif [[ "$1" == "surf" || "$1" == "proposal" ]]; then
		cd "/home/sam/CMU/Research/3D Pose HARP/SURF Proposal";
		#ssh -NfL 6006:localhost:6006 bigfoot
	elif [[ "$1" == "researchcode" || "$1" == "research code" ]]; then
		cd "/home/sam/CMU/Research/Radar Odometry/pharao";
		# pyenv activate vol;
	elif [[ "$1" == "detectron2" || "$1" == "detectron" ]]; then
		cd "/home/sam/CMU/Research/3D Pose HARP/Code/detectron2";
		pyenv activate vol;	
	elif [[ "$1" == "processing" || "$1" == "process" || "$1" == "preprocessing" ]]; then
		cd "/home/sam/CMU/Research/3D Pose HARP/Code/learnable-triangulation-pytorch/mvn/datasets/cmu_preprocessing";
	elif [[ "$1" == "225" || "$1" == "36225" || "$1" == "probability" ]]; then
		cd "/home/sam/CMU/Study/36225/homework"
	elif [[ "$1" == "225hw" || "$1" == "36225hw" || "$1" == "225hmwk" || "$1" == "36225hmwk" ]]; then
		cd "/home/sam/CMU/Study/36225/homework"	
		cd `cat .active_hw_dir`
	elif [[ "$1" == "18240" || "$1" == "240" ]]; then
		cd "/home/sam/CMU/Study/18240"
	elif [[ "$1" == "240hw" || "$1" == "240hwmk" ]]; then
		cd "/home/sam/CMU/Study/18240/homework"
		cd `cat .active_hw_dir`
	elif [[ "$1" == "240lab" || "$1" == "240labs" ]]; then
		cd "/home/sam/CMU/Study/18240/labs"
	elif [[ "$1" == "16385" || "$1" == "computervision" || "$1" == "cv" || "$1" == "CV" ]]; then
		cd "/home/sam/CMU/Study/16385 Computer Vision"
	elif [[ "$1" == "cvcode" ]]; then
		cd "/home/sam/CMU/Study/16385 Computer Vision/programming"
	elif [[ "$1" == "21260" || "$1" == "diffeq" || "$1" == "260" ]]; then
		cd "/home/sam/CMU/Study/21260 Diff Eq/homework"
	elif [[ "$1" == "260hw" || "$1" == "diffeqhw" || "$1" == "260hmwk" ]]; then
		cd "/home/sam/CMU/Study/21260 Diff Eq/homework"
		cd `cat .active_hw_dir`
	elif [[ "$1" == "sisyphus"* ]]; then
		cd ~/Documents/MobileApps/SisyphusSheep;
	elif [[ "$1" == "telegram" ]]; then
		cd ~/Documents/Telegram\ Bots/;
	elif [[ "$1" == "biblequizzle" || "$1" == "quizzle" ]]; then
		cd ~/Documents/Telegram\ Bots/BibleQuizzle;
	elif [[ "$1" == "unreal" || "$1" == "ut" || "$1" == "ut2004" ]]; then
		cd ~/Downloads/ut2004
		./runGame
		cd -
		xrandr --output eDP1 --left-of HDMI1
	elif [[ "$1" == "pinball" ]]; then
		cd ~/Downloads/pinball
		wine pinball.exe
	elif [[ "$1" == "website" || "$1" == "github" ]]; then
		cd ~/Documents/Github\ Website
	elif [[ "$1" == "resume" ]]; then
		cd "/home/sam/Documents/Github Website/resumecv"
	else
		cd "$1" || cd ~/"$1";
	fi
}

export -f goto

# Sync 240 folder with Github (because ECE servers no Internet connection)
240sync(){
	if [[ ! -z "$1" ]]; then
		goto 240
		gitpush "$1"
		cd -
		echo ""
	fi

	echo "Syncing with Andrew servers... "
	sshpass -p $(gpg -d -q ~/.ssh/.andrewpwd.gpg) ssh $ANDREW_LINUX 'cd ~/private/18240 && git pull && echo -e "Success!\n" || echo -e  "Failure!\n"; git add . && git commit -m"Update from server" && git push && exit'

	# Sync locally
	echo -e "\nSyncing locally... "
	goto 240 && git pull && cd - && echo "Success!" || echo "Failure!"
}

# Update all instances of sammath
updatesammath(){
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

# Research stuff
harptensor(){
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
savescripts(){
	FOLDER_DIR=/home/sam/bash_scripts/

	MESSAGE=${@:$#} # last parameter 
	FILES=${*%${!#}} # all parameters except the last

	cp $FILES $FOLDER_DIR
	cd $FOLDER_DIR
	gitpush "$MESSAGE"
	cd -
}

# Split PDFs into individual pages
splitpdf(){
	filename="$1"
	filename=${filename%.*}
	mkdir $filename
	pdftk "$filename.pdf" burst output "$filename/$filename-%d.pdf"
}

# Create blank page
createBlankPDF(){
	numberOfPages=${1:-1}
	echo '\documentclass{article}' > blank.tex
	echo '\usepackage{pdfpages}' >> blank.tex
	echo '\begin{document}' >> blank.tex
	for((i=1;i<=$numberOfPages;i++)); do 
		echo '\newpage\null\thispagestyle{empty}\newpage'
	done >> blank.tex
	echo '\end{document}' >> blank.tex

	: | pdflatex -halt-on-error blank.tex | grep '^!.*' -A200 --color=always

	# Keep only the pdf
	rm blank.{tex,out,log,aux,bbl,blg,dvi,toc,synctex.gz} > /dev/null 2>&1

	echo "blank.pdf created with $numberOfPages blank page(s)"
}

export -f createBlankPDF

# PDF TO BOOKLET
pdf2book(){
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
pdf2jpg(){
	PDF=$1

	echo "Processing $PDF"
	DIR=`basename "$1" .pdf`

	mkdir "$DIR"

	echo '  Splitting PDF file to pages...'
	pdftk "$PDF" burst output "$DIR"/%04d.pdf
	pdftk "$PDF" dump_data output "$DIR"/metadata.txt

	echo '  Converting pages to JPEG files...'
	for i in "$DIR"/*.pdf; do
		convert -colorspace RGB -interlace none -density 300x300 -quality 100 "$i" "$DIR"/`basename "$i" .pdf`.jpg
	done

	rm "$DIR/*.pdf"
	rm "$DIR/*.txt"	

	echo 'All done'
}

alias pdf2img=pdf2jpg
export -f pdf2jpg

img2pdf(){
	IMAGES="${@:1:$#-1}"
	OUTPUT="${!#}" # get last element
	
	echo "Combining $IMAGES into $OUTPUT..."

	convert "$IMAGES" -quality 100 "$OUTPUT"

	echo "Done!"
}

export -f img2pdf

# Compress video using ffmpeg
compress-video(){
	if [ -z $2 ]; then 
		COMPRESS_RATE=24;
	else
		COMPRESS_RATE=$2;
	fi
	
	FILENAME=$1
	if [ -f "$FILENAME" ]; then
		FILENAME="${FILENAME%.*}"
	elif [ -f "$FILENAME.mp4" ]; then 
		FILENAME="$1"
	else
		echo "File $FILENAME does not exist"
		return 1
	fi

	ffmpeg -i "$1" -vcodec libx265 -crf $COMPRESS_RATE "$FILENAME-compressed.mp4"
}

# Programming handin function
sshshark(){
    if [ -z $1 ]; then
        SHARK_URL=$ANDREW_SHARK
	else 
		SHARK_URL="scleong@$1shark.ics.cs.cmu.edu"
    fi

    sshpass -p $(gpg -d -q ~/.ssh/.andrewpwd.gpg) ssh -X $SHARK_URL;
}

122lab(){
	sshpass -p $(gpg -d -q ~/.ssh/.andrewpwd.gpg) ssh -X $ANDREW_LINUX '/afs/andrew/course/15/122/bin/122lab';
	exit;
}

handin(){
	FOLDER_NAME=${PWD##*/}
	BASE_DIRECTORY="~/private/18213"
	COPY_TO="$ANDREW_LINUX:$BASE_DIRECTORY/$FOLDER_NAME"

	gpg -d -q ~/.ssh/.andrewpwd.gpg > .fifo_temp

	sshpass -f .fifo_temp ssh $ANDREW_LINUX 'cd '$BASE_DIRECTORY' && mkdir -p '$FOLDER_NAME

	tar -czvf handin.tar ${@:2} && \
	sshpass -f .fifo_temp scp ./handin.tar $COPY_TO && \
	sshpass -f .fifo_temp ssh $ANDREW_LINUX 'cd '$BASE_DIRECTORY'/'$FOLDER_NAME' && tar -xzvf handin.tgz && yes yes | /afs/andrew/course/15/213/bin/handin '$@' && echo "Complete"'

	rm ./.fifo_temp
	rm ./handin.tar
}

scptoandrew(){
	COPY_TO="$ANDREW_LINUX:$2"

	gpg -d -q ~/.ssh/.andrewpwd.gpg > .fifo_temp
	sshpass -f .fifo_temp scp $1 $COPY_TO
	rm ./.fifo_temp
}

scpfromandrew(){
	COPY_FROM="$ANDREW_LINUX:$1"

	gpg -d -q ~/.ssh/.andrewpwd.gpg > .fifo_temp
	sshpass -f .fifo_temp scp $COPY_FROM $2
	rm ./.fifo_temp
}

export -f scptoandrew
export -f scpfromandrew

imagediff(){
	BASE_DIRECTORY="~/private/15122/3/imagediff"
	COPY_TO="$ANDREW_LINUX:$BASE_DIRECTORY"

	gpg -d -q ~/.ssh/.andrewpwd.gpg > .fifo_temp

	sshpass -f .fifo_temp scp $1 $2 $COPY_TO/images
	sshpass -f .fifo_temp ssh $ANDREW_LINUX 'cd '$BASE_DIRECTORY'; /afs/andrew/course/15/122/bin/imagediff -i '$1' -j '$2' -o diff.png'
	sshpass -f .fifo_temp scp "$COPY_TO/diff.png" ./images
	sshpass -f .fifo_temp ssh $ANDREW_LINUX 'cd '$BASE_DIRECTORY'; rm '$1' '$2' diff.png'

	rm ./.fifo_temp

	display ./images/diff.png
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/sam/.sdkman"
[[ -s "/home/sam/.sdkman/bin/sdkman-init.sh" ]] && source "/home/sam/.sdkman/bin/sdkman-init.sh"

# Quartus Paths
export ALTERAPATH="/home/sam/intelFPGA_lite/20.1"
export ALTERAOCLSDKROOT="${ALTERAPATH}/hld"
export QUARTUS_ROOTDIR=${ALTERAPATH}/quartus
export QUARTUS_ROOTDIR_OVERRIDE="$QUARTUS_ROOTDIR"
export QSYS_ROOTDIR="${ALTERAPATH}/quartus/sopc_builder/bin"
export PATH=$PATH:${ALTERAPATH}/quartus/bin
export PATH=$PATH:${ALTERAPATH}/nios2eds/bin
