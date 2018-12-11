#!/bin/bash
########################################
# OpenCV package build/install
########################################
# NEED 15GB disk space with contrib
SCRIPT_DIR=$(cd $(dirname $0); pwd)
# cudaコンパイラのnvccは-std=c++11を扱えないのでFLAGを立てないこと
# WITH_TBB=ON, WITH_CUDA=OFF (fast) vs WITH_TBB=OFF WITH_CUDA=ON (slow)
# WITH_QT=ON, WITH_GTK=OFF vs WITH_QT=OFF, WITH_GTK=ON
# CMAKE_C_FLAGS="-march=native", linux/videodev2.h - found vs CMAKE_C_FLAGS="-std=c11 -march=native", linux/videodev2.h - not found
# ENABLE_CXX11=OFF, HAVE_CXX11=OFF, MAKE_CXX_FLAGS="-std=c++14 -march=native" vs ENABLE_CXX11=ON, HAVE_CXX11=ON, MAKE_CXX_FLAGS="-march=native"

# XIMEA camera driver
#wget https://www.ximea.com/downloads/recent/XIMEA_Linux_SP.tgz
#tar xzf XIMEA_Linux_SP.tgz
#cd package
#./install
#cd -
#rm -rf package
#/opt/XIMEA/uninstall

apt-get install -y build-essential cmake libeigen3-dev libatlas-base-dev gfortran wget libavresample-dev ffmpeg pkg-config unzip qtbase5-dev libdc1394-22 libdc1394-22-dev libjpeg-dev libpng++-dev libopenexr-dev libtiff-dev libwebp-dev libavcodec-dev libavformat-dev libswscale-dev libxine2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libv4l-dev libtbb-dev libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev v4l-utils qv4l2 v4l2ucp liblapacke-dev libopenblas-dev checkinstall libgdal-dev libgphoto2-dev libjasper-dev libx264-dev qt5-default freeglut3-dev libgdcm2-dev libvtk6-dev libvtk6-qt-dev


c++ -x c++ -dM -E - < /dev/null | grep cplus
#define __cplusplus 201402L

SOURCE_PATH=/mnt/ssd250/compile
VERSION=3.4.1
CUDA_COMPUTE_CAPABILITIES=7.2 # Xavier:7.2, TX2:6.2, TX1:5.3
FAKE_INSTALL_PATH=/package_build

mkdir -p ${SOURCE_PATH} \
&& rm -rf ${SOURCE_PATH}/opencv-${VERSION} \
&& rm -rf ${SOURCE_PATH}/opencv_contrib-${VERSION} \
&& rm -rf ${FAKE_INSTALL_PATH}

if [ ! -e ${SOURCE_PATH}/opencv-${VERSION}.zip ]; then
    wget --no-check-certificate https://github.com/opencv/opencv/archive/${VERSION}.zip -O ${SOURCE_PATH}/opencv-${VERSION}.zip
fi
if [ ! -e ${SOURCE_PATH}/opencv_contrib-${VERSION}.zip ]; then
    wget https://github.com/opencv/opencv_contrib/archive/${VERSION}.zip -O ${SOURCE_PATH}/opencv_contrib-${VERSION}.zip
fi
cd ${SOURCE_PATH} \
&& unzip opencv-${VERSION}.zip \
&& unzip opencv_contrib-${VERSION}.zip \
&& mkdir -p opencv-${VERSION}/build \
&& cd opencv-${VERSION}/build


time cmake \
     -D OPENCV_EXTRA_MODULES_PATH=${SOURCE_PATH}/opencv_contrib-${VERSION}/modules \
     -D ENABLE_NEON=ON \
     -D ENABLE_FAST_MATH=ON \
     -D ENABLE_CXX11=OFF \
     -D HAVE_CXX11=OFF \
     -D CMAKE_C_FLAGS="-march=native" \
     -D CMAKE_CXX_FLAGS="-std=c++14 -march=native" \
     -D CMAKE_BUILD_TYPE=RELEASE \
     -D CMAKE_INSTALL_PREFIX=/usr/local \
     -D WITH_1394=ON \
     -D WITH_CAROTENE=ON \
     -D WITH_CUBLAS=ON \
     -D WITH_CUDA=ON \
     -D WITH_CUFFT=ON \
     -D WITH_NVCUVID=ON \
     -D WITH_EIGEN=ON \
     -D WITH_FFMPEG=ON \
     -D WITH_GPHOTO2=ON \
     -D WITH_GIGEAPI=OFF \
     -D WITH_GSTREAMER=ON \
     -D WITH_GSTREAMER_0_10=OFF \
     -D WITH_GTK=OFF \
     -D WITH_INTELPERC=OFF \
     -D WITH_IPP=OFF \
     -D WITH_IPP_A=OFF \
     -D WITH_JPEG=ON \
     -D WITH_ZLIB=ON \
     -D WITH_JASPER=ON \
     -D WITH_PNG=ON \
     -D WITH_OPENEXR=ON \
     -D WITH_WEBP=ON \
     -D WITH_GDAL=ON \
     -D WITH_GDCM=ON \
     -D WITH_TIFF=ON \
     -D WITH_OPENCL=ON \
     -D WITH_OPENCLAMDBLAS=ON \
     -D WITH_OPENCLAMDFFT=ON \
     -D WITH_OPENCL_SVM=ON \
     -D WITH_OPENGL=ON \
     -D WITH_OPENMP=OFF \
     -D WITH_OPENNI=OFF \
     -D WITH_PTHREADS_PF=ON \
     -D WITH_PVAPI=OFF \
     -D WITH_QT=ON \
     -D WITH_TBB=ON \
     -D WITH_UNICAP=OFF \
     -D WITH_V4L=ON \
     -D WITH_LIBV4L=ON \
     -D WITH_VTK=ON \
     -D WITH_XIMEA=OFF \
     -D WITH_XINE=ON \
     -D CUDA_ARCH_BIN=$CUDA_COMPUTE_CAPABILITIES \
     -D CUDA_ARCH_PTX="" \
     -D CUDA_FAST_MATH=ON \
     -D CUDA_NVCC_FLAGS="-D_FORCE_INLINES --expt-relaxed-constexpr" \
     -D CUDA_CUDA_LIBRARY=/usr/lib/aarch64-linux-gnu/libcuda.so \
     -D BUILD_EXAMPLES=OFF \
     -D BUILD_DOCS=OFF \
     -D BUILD_TESTS=OFF \
     -D BUILD_PREF_TESTS=OFF \
     -D BUILD_opencv_python2=ON \
     -D BUILD_opencv_python3=ON \
     -D PYTHON_DEFAULT_EXECUTABLE=$(which python3) \
     -D PYTHON2_EXECUTABLE=$(which python2) \
     -D PYTHON2_NUMPY_INCLUDE_DIRS=/usr/local/lib/python2.7/dist-packages/numpy/core/include \
     -D PYTHON3_EXECUTABLE=$(which python3) \
     -D PYTHON3_NUMPY_INCLUDE_DIRS=/usr/local/lib/python3.6/dist-packages/numpy/core/include \
     ..

# https://devtalk.nvidia.com/default/topic/1036716/cuda-programming-and-performance/check-for-expt-relaxed-constexpr/
# https://stackoverflow.com/questions/11307465/destdir-and-prefix-of-make
# make install DESTDIR=***

time make -j $(($(nproc) + 1))
time make install DESTDIR=$FAKE_INSTALL_PATH/opencv-${VERSION}/


mkdir -p $FAKE_INSTALL_PATH/opencv-${VERSION}/etc/ld.so.conf.d
echo "/usr/local/lib" > $FAKE_INSTALL_PATH/opencv-${VERSION}/etc/ld.so.conf.d/opencv.conf


mkdir -p $FAKE_INSTALL_PATH/opencv-${VERSION}/DEBIAN \
&& cd $FAKE_INSTALL_PATH \
&& echo -e "Source: opencv-${VERSION}
Package: opencv
Version: ${VERSION}
Priority: optional
Maintainer: Yoshiroh Takanashi <takanashi@gclue.jp>
Architecture: arm64
Depends: 
Description: OpenCV version ${VERSION}"\
> $FAKE_INSTALL_PATH/opencv-${VERSION}/DEBIAN/control \
&& fakeroot dpkg-deb --build opencv-${VERSION}

mkdir -p $SCRIPT_DIR/../binary
mv -f $FAKE_INSTALL_PATH/opencv-${VERSION}.deb $SCRIPT_DIR/../binary
