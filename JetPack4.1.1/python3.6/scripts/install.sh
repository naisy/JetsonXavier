#!/bin/bash
# 再起動が入るsetup.shを先に実行しておく
# apt-get install でエラーが出たら、/usr/bin/pythonのリンクを2.7にしてapt-get removeする
# ModuleNotFoundError: No module named 'ConfigParser'
# sudo rm /usr/bin/python
# sudo ln -s /usr/bin/python2.7 /usr/bin/python

########################################
# Check Ubuntu version
########################################
lsb_release -a


########################################
# Ubuntu 18.04 パッケージ更新
########################################
apt-get update
apt-get install -y htop locate arp-scan


########################################
# pip install
########################################
./install_pip3.sh


########################################
# coco/PythonAPI
########################################
./install_cocopy.sh


########################################
# Java8 インストール
########################################
./install_java8.sh


########################################
# Build Tools インストール
########################################
./install_build_tools.sh


########################################
# CUDA deviceQueryビルド
########################################
./install_cuda_deviceQuery.sh


########################################
# パッケージ作成/インストール準備
########################################
# 自作パッケージはXavierデフォルトのarm64で作る
dpkg --print-architecture


########################################
# patch CUDA GL ARM for OpenCV Build
########################################
./patch_cuda_gl.sh
ln -s /usr/include/libv4l1-videodev.h /usr/include/linux/videodev.h


########################################
# libjasper-dev for OpenCV Build
########################################
deb http://ports.ubuntu.com/ubuntu-ports/ xenial-updates main
add-apt-repository "deb http://ports.ubuntu.com/ubuntu-ports/ xenial-updates main"
apt-get update


########################################
# OpenCV
########################################
#build_opencv-3.4.1.sh
./install_opencv-3.4.1.sh


########################################
# bazel
########################################
#./build_bazel.sh


########################################
# TensorFlow
########################################
#./build_tensorflow.sh
#TF=1.10.1
#PY=36
#./join_tensorflow_whl.sh $TF $PY
#./install_tensorflow.sh $TF $PY

