# Jetson Xavier settings

Install OpenCV/Tensorflow on Jetson Xavier.

## ssh login to Xavier  
> ssh ubuntu@192.168.x.x  

## 1. git clone
> git clone https://github.com/naisy/JetsonXavier  
> cd JetsonXavier  

## 2. show branch
> git branch -r  

## 3. checkout branch
> git checkout JetPack4.1.1_python3.6  

## 4. Setting before install
> cd JetPack4.1.1/python3.6/scripts  
> find ./ -type f | xargs -n1 sed -i "s/\r//g"  
> chmod 755 *.sh  
>  
> sudo su  
> ./setup.sh  

It will restart automatically when setup.sh is done.  
Re-login.  

## 5. Install
> sudo su  
> nvpmodel -m 0  
> ./jetson_clocks.sh  
> cd JetsonXavier/JetPack4.1.1/python3.6/scripts  
> ./install.sh  

## 6. Install Tensorflow
pip3 install --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v411 tensorflow-gpu
