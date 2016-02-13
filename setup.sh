#!/bin/bash/

# Establish logging for Pi Setup process
LOG="virtual_env_install.log"
exec &> >(tee $LOG)

# Create useful variables
PYTHON="pyEnv"
PROJECT="outback_challenge"

# Return to root of user directory, remove previous environment setup
cd ~
rm -rfv $PROJECT

# Step 0:
# Update Pi and package list
echo "** Updating initial install **"
sudo apt-get -y update
sudo apt-get -y upgrade
sudo rpi-update

# Step 1:
# Install core python
echo "** Adding core programs **"
sudo apt-get -y install python-pip python-virtualenv
sudo rm -rf ~/.cache/pip

echo "** Building/Rebuilding python virtual environment **"
rm -rf $PYTHON

echo "** Creating directory structure **"
mkdir $PROJECT
cd $PROJECT

mkdir "tests"
mkdir "scripts"
mkdir "modules"
mkdir "documentation"

echo "** Create virtual environment **"
virtualenv -p /usr/bin/python2.7 $PYTHON
source $PYTHON/bin/activate

echo "** Dronekit for UAV development **"
sudo apt-get -y build-dep python-serial python-pyparsing python-numpy

pip install pyserial pyparsing numpy
pip install dronekit
pip install dronekit-sitl -UI

sudo usermod -a -G dialout,kmem $USER

echo "** Profile setup **"
echo "source ~/$PROJECT/$PYTHON/bin/activate" >> ~/.profile
echo "cd ~/$PROJECT" >> ~/.profile
echo "export PYTHONPATH=~/$PROJECT/modules" >> ~/.profile
echo "export PYTHONPATH=$PYTHONPATH:~/$PROJECT/tests" >> ~/.profile

sudo reboot

#sudo apt-get install -y build-essential cmake pkg-config

# Installing OpenCV packages
# Install image I/O packages
#sudo apt-get install -y libjpeg8-dev libtiff4-dev libjasper-dev libpng12-dev

# Install GTK development library to view images in GUI
#sudo apt-get install -y libgtk2.0-dev

# Install video I/O packages
#sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev

# Install OpenCV optimisation libraries
#sudo apt-get install -y libatlas-base-dev gfortran

# Update profile
# virtualenv and virtualenvwrapper
#export WORKON_HOME=$HOME/.virtualenvs
#source /usr/local/bin/virtualenvwrapper.sh

# Reload profile
#source ~/.profile

# Create virtual environment for OpenCV development
#mkvirtualenv cv

# Install Python development tools
#sudo apt-get install -y python2.7-dev

# Download and unpack OpenCV
#wget -O opencv-2.4.10.zip http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.4.10/opencv-2.4.10.zip/download
#unzip opencv-2.4.10.zip
#cd opencv-2.4.10

# Setup the build
#mkdir build
#cd build
#cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_V4L=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON  -D BUILD_EXAMPLES=ON ..

# Install; make sure you are in the virtual environment before proceeding
#make
#sudo make install
#sudo ldconfig

# Now link to python libraries
#cd ~/$ENV/lib/python2.7/site-packages/
#ln -s /usr/local/lib/python2.7/site-packages/cv2.so cv2.so
#ln -s /usr/local/lib/python2.7/site-packages/cv.py cv.py
