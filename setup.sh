#!/bin/bash/
# Step 0:
# Update Pi and package list
sudo apt-get -y update
sudo apt-get -y upgrade
sudo rpi-update

# Step 1:
# Install developer tools
sudo apt-get install -y build-essential cmake pkg-config

# Installing OpenCV packages
# Install image I/O packages
sudo apt-get install -y libjpeg8-dev libtiff4-dev libjasper-dev libpng12-dev

# Install GTK development library to view images in GUI
sudo apt-get install -y libgtk2.0-dev

# Install video I/O packages
sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev

# Install OpenCV optimisation libraries
sudo apt-get install -y libatlas-base-dev gfortran

# Installing Python packages
# Install pip
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py

# Install virtualenv and virtualenvwrapper
sudo pip install virtualenv virtualenvwrapper
sudo rm -rf ~/.cache/pip

# Update profile
# virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# Reload profile
source ~/.profile

# Create virtual environment for OpenCV development
mkvirtualenv cv

# Install Python development tools
sudo apt-get install -y python2.7-dev

# Install numpy
pip install numpy

# Download and unpack OpenCV
wget -O opencv-2.4.10.zip http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.4.10/opencv-2.4.10.zip/download
unzip opencv-2.4.10.zip
cd opencv-2.4.10

# Setup the build
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_V4L=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON  -D BUILD_EXAMPLES=ON ..

# Install; make sure you are in the virtual environment before proceeding
make
sudo make install
sudo ldconfig

# Now link to python libraries
cd ~/$ENV/lib/python2.7/site-packages/
ln -s /usr/local/lib/python2.7/site-packages/cv2.so cv2.so
ln -s /usr/local/lib/python2.7/site-packages/cv.py cv.py

# Reboot to apply changes, and use updated firmware
sudo reboot
