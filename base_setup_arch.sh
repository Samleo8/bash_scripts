#!/bin/bash

# USAGE
# Setups and installs software and dependencies

#Flags. Manually set before run.
DISABLE_BLUETOOTH_STARTUP=1

INSTALL_PROGRAMMER=1
CONFIG_GIT_SSH=1
INSTALL_UTILITIES=1
INSTALL_BROWSER_EDITORS=1
INSTALL_EXTENSIONS=1

INSTALL_MISC=0

#Disable bluetooth on startup
if [ $DISABLE_BLUETOOTH_STARTUP -eq 1 ]; then
	echo "Installing disable bluetooth startup script in /etc/rc.local ..."

	touch rc.local
	echo -e '#!/bin/sh\nrfkill block bluetooth\nexit 0' > rc.local
	#sudo mv rc.local /etc/rc.local

	sudo install -b -m 755 rc.local /etc/rc.local
	rm rc.local
	echo "Bluetooth should now be disabled on startup!"
fi

#Install programs


## Programmer software
if [ $INSTALL_PROGRAMMER -eq 1 ]; then
	echo "Installing programming software..."

	yes | sudo pacman -S curl cmake
	yes | sudo pacman -S ruby npm
	yes | sudo pacman -S git git-lfs
	yes | sudo pacman -S python-pip python3-pip
	yes | sudo pacman -S openmp

	echo "Programming software installed!"
fi

## Utilities software
if [ $INSTALL_UTILITIES -eq 1 ]; then
	echo "Install utilities..."

	yes | sudo pacman -S htop hardinfo
	yes | sudo pacman -S wmctrl xdotool
	yes | sudo pacman -S youtube-dl

	if [ $INSTALL_PROGRAMMER -eq 1 ]; then
		yes | sudo npm install -g linux-window-session-manager
		yes | sudo npm install -g now --unsafe-perm
		
		sudo gem install fusuma -y
		mkdir -p ~/.config/fusuma
	fi

	yes | yay -S --noprovides font-manager pdftk masterpdfeditor
	
	#PDF Grep	
	git clone https://gitlab.com/pdfgrep/pdfgrep.git _pdfgrep
	cd _pdfgrep
	yes | sudo pacman -S poppler libgcrypt
    ./configure
    make
    sudo make install
	cd ..
	rm -rf _pdfgrep
	
	yes | sudo pacman -S tlp tlp-rdw

	echo "Utilities installed!"
fi

## Browsers and Editors
if [ $INSTALL_BROWSERS_EDITORS -eq 1 ]; then
	echo "Installing web browsers and editors..."

	yes | sudo pacman -S chromium
	yes | sudo pacman -S gimp
	yes | sudo pacman -S texstudio
	yes | sudo pacman -S vlc
	yes | sudo pacman -S atom
	
	yes | yay -S --noprovides flowblade


	echo "Installing extensions..."

	### Extensions
	if [ $INSTALL_EXTENSIONS -eq 1 ]; then
		echo "Installing extensions..."

		yes | sudo pacman -S flashplugin
		yes | yay -S --noprovides gimp-plugin-registry
		yes | sudo pacman -S gscan2pdf

		echo "Extensions installed!"
	fi
fi

## Misc
if [ $INSTALL_MISC -eq 1 ]; then
	yes | sudo pacman -S krb5-user
	yes | sudo pacman -S tensorrt
fi

# Config git ssh: Requires manual entry 
if [[ $CONFIG_GIT_SSH -eq 1 && $INSTALL_PROGRAMMER -eq 1 ]]
then
	ssh-keygen -t rsa -b 4096 -C "leowhiz@yahoo.com.sg"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa

	cat ~/.ssh/id_rsa.pub | xclip -selection c

	echo "SSH Public key has been copied to clipboard. Add it to github at https://github.com/settings/keys"
fi

echo "You might also want to install cuda, cudnn and opencv."
