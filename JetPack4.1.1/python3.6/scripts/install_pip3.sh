########################################
# pip3 install
########################################
apt-get install -y python3-dev libjpeg-dev libxslt-dev libxml2-dev libffi-dev libcurl4-openssl-dev libssl-dev libblas-dev liblapack-dev gfortran libpng-dev libfreetype6-dev libhdf5-dev

#more /usr/bin/pyversions (print msg)

rm -rf /usr/bin/python && ln -s /usr/bin/python3.6 /usr/bin/python
apt-get install -y curl
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py
rm -rf get-pip.py

pip3 install testresources
pip3 install --upgrade pip
pip3 install --upgrade setuptools
pip3 install --upgrade numpy
#pip3 install --upgrade scipy
#pip3 install --upgrade pandas
pip3 install --upgrade matplotlib
#pip3 install --upgrade seaborn
#pip3 install --upgrade requests
pip3 install --upgrade futures
pip3 install --upgrade Pillow
#pip3 install --upgrade sklearn
#pip3 install --upgrade tqdm
pip3 install --upgrade cython
pip3 install --upgrade scikit-image
#pip3 install --upgrade smbus2
#pip3 install --upgrade spidev
#pip3 install --upgrade absl-py
#pip3 install --upgrade sympy
pip3 install --upgrade pyyaml
pip3 install --upgrade h5py
pip3 install --upgrade keras
pip3 install --upgrade enum34
pip3 install --upgrade mock

#pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U
