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
	
	sudo apt install cmake ruby npm -y
	sudo apt install git git-lfs -y
	sudo apt install default-jre oracle-java11-installer -y
	sudo apt install python-pip python3-pip -y
	sudo apt install libomp-dev -y

	echo "Programming software installed!"
fi

## Utilities software
if [ $INSTALL_UTILITIES -eq 1 ]; then
	echo "Install utilities..."
	
	sudo apt install htop hardinfo -y
	sudo apt install wmctrl xdotool -y
	sudo apt install gnome-tweaks -y
	sudo apt-get install libinput-tools -y

	if [ $INSTALL_PROGRAMMER -eq 1 ]; then
		sudo apt install npm
		sudo npm install -g linux-window-session-manager -y
		sudo npm install -g now -y
	fi

	sudo apt install font-manager pdf-tk pdf-shuffler -y
	sudo apt install tlp tlp-rdw -y

	echo "Utilities installed!"
fi

## Browsers and Editors
if [ $INSTALL_BROWSERS_EDITORS -eq 1 ]; then
	echo "Installing web browsers and editors..."

	sudo apt install chromium-browser -y
	sudo apt install gimp -y
	sudo apt install texstudio -y
	sudo apt install vlc -y
	#sudo apt install atom -y
	CURR_DIR=`pwd`
	cd ~/Downloads	
	wget https://github.com/jliljebl/flowblade/releases/download/v2.0/flowblade-2.0.0-1_all.deb
 	sudo apt install ./flowblade-2.0.0-1_all.deb -y
	cd $CURR_DIR

	echo "Installing extensions..."

	### Extensions
	if [ $INSTALL_EXTENSIONS -eq 1 ]; then
		echo "Installing extensions..."

		sudo apt install adobe-flashplugin -y
		sudo apt install gimp-plugin-registry gscan2pdf -y

		echo "Extensions installed!"
	fi
fi

## Misc
if [ $INSTALL_MISC -eq 1 ]; then
	sudo apt install krb5-user -y
	sudo apt install tensorrt -y

	if [ $INSTALL_PROGRAMMER -eq 1 ]; then
		sudo gem install fusuma
		mkdir -p ~/.config/fusuma
	fi	

fi

# Config git ssh: Requires manual entry 
if [ $CONFIG_GIT_SSH -eq 1 ] && [ $INSTALL_PROGRAMMER -eq 1 ]; then
	ssh-keygen -t rsa -b 4096 -C "leowhiz@yahoo.com.sg"
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa

	cat ~/.ssh/id_rsa.pub | xclip -selection c
	
	echo "SSH Public key has been copied to clipboard. Add it to github at https://github.com/settings/keys"
fi

echo "You might also want to install cuda, cudnn and opencv. Also install atom via snap/Ubuntu software"
