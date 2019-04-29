# USAGE
# Run to install opencv with CUDA and OPENMP support. Works for python and C.
# If DOWNLOAD_FROM_SOURCE=0, then needs to be run in a directory containing the downloaded opencv and opencv_contrib directories.

#Flags. For now, manually edit
INSTALL_PYTHON_PACKAGES=1
DOWNLOAD_FROM_SOURCE=0
N_THREADS=`nproc` #either let automatically detect, or manually put

#Installation of Python Packages
if [ $INSTALL_PYTHON_PACKAGES -eq 1 ]
then
	#Install Image IO Packages
	echo "Installing Image I/O Packages"
	sudo apt-get install libjpeg-dev libpng-dev libtiff-dev -y

	#Install Video IO Packages
	echo "Installing Video I/O Packages"
	sudo apt-get install libavcodec-dev libavformat-dev dev-libv4l dev-libswscale -y
	sudo apt-get install libxvidcore-dev libx264-dev -y
	#sudo apt-get install libxine2-dev libv4l-dev libdc1394-22-dev -y
	sudo apt-get install libgstreamer-dev libgstreamer-plugins-base-dev -y
	sudo apt-get install qt5-default -y

	#Install GTK
	echo "Installing GTK (GUI library)"
	sudo apt-get install libgtk-3-dev -y

	#Install Optimisers
	echo "Installing Optimisers"
	sudo apt-get install libatlas-base-dev gfortran -y

	#Install Python Headers and Libraries
	echo "Installing Optimisers"
	sudo apt-get install python-dev python3-dev -y
fi

#Download from source
if [ $DOWNLOAD_FROM_SOURCE -eq 1 ] 
then
	echo "Downloading opencv and opencv_contrib from github"
	git clone https://github.com/opencv/opencv.git
	git clone https://github.com/opencv/opencv_contrib.git
fi

echo "Building OpenCV..."
cd opencv
mkdir build
cd build

echo "C-Making opencv..."
cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D INSTALL_C_EXAMPLES=ON \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D OPENCV_ENABLE_NONFREE=ON \
      -D WITH_PNG=ON \
      -D WITH_TIFF=ON \
      -D WITH_JPEG=ON \
      -D WITH_OPENGL=ON \
      -D WITH_OPENMP=ON \
      -D OPENCV_GENERATE_PKGCONFIG=YES \
      -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
      -D BUILD_EXAMPLES=ON ..

#Make based on number of threads for multi-threading
echo "$N_THREADS detected. Making OpenCV to use $N_THREADS..."
if [ $N_THREADS -eq 16 ]; then
	make -j16
elif [ $N_THREADS -eq 8 ]; then
	make -j8
elif [ $N_THREADS -eq 6 ]; then
	make -j6
elif [ $N_THREADS -eq 4 ]; then
	make -j4
elif [ $N_THREADS -eq 2 ]; then
	make -j2
else
	make
fi

#Install
echo "Installing OpenCV..."
sudo make install
sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig

#Setting up opencv for python
echo "Setting up opencv for python..."
mv /usr/local/lib/python2.7/dist-packages/cv2*.so usr/local/lib/python2.7/dist-packages/cv2.so
mv /usr/local/lib/python3.6/dist-packages/cv2*.so usr/local/lib/python3.6/dist-packages/cv2.so
