DOWNLOAD_DEB_FILE=0

if [ $DOWNLOAD_DEB_FILE -eq 1 ]; then
	wget https://developer.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda-repo-ubuntu1810-10-1-local-10.1.105-418.39_1.0-1_amd64.deb
fi

sudo dpkg -i cuda-repo-ubuntu1810-10-1-local-10.1.105-418.39_1.0-1_amd64.deb
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1810/x86_64/7fa2af80.pub
#sudo apt-key add /var/cuda-repo-10.1/7fa2af80.pub
sudo apt-get update
sudo apt-get install cuda -y
