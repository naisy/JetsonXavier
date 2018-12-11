##############################
# Tensorflow 1.10.1
##############################
pip3 install tensorflow-1.10.1-cp36-cp36m-linux_aarch64.whl

########################################
# OpenCV 3.4.1
########################################
apt-get install -y build-essential cmake libeigen3-dev libatlas-base-dev gfortran wget libavresample-dev ffmpeg pkg-config unzip qtbase5-dev libdc1394-22 libdc1394-22-dev libjpeg-dev libpng++-dev libopenexr-dev libtiff-dev libwebp-dev libavcodec-dev libavformat-dev libswscale-dev libxine2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libv4l-dev libtbb-dev libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev v4l-utils qv4l2 v4l2ucp liblapacke-dev libopenblas-dev checkinstall libgdal-dev libgphoto2-dev libjasper-dev libx264-dev qt5-default freeglut3-dev libgdcm2-dev libvtk6-dev libvtk6-qt-dev

dpkg -i opencv-3.4.1.deb
ldconfig

########################################
# Uninstall Tensorflow
########################################
pip3 uninstall tensorflow

########################################
# Uninstall Opencv
########################################
apt-get remove opencv
