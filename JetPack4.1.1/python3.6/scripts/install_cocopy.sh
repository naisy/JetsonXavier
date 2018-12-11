#!/bin/bash
########################################
# coco/PythonAPI
########################################
git clone https://github.com/pdollar/coco.git \
&& cd coco/PythonAPI \
&& make \
&& make install \
&& python setup.py install \
&& cd - \
&& rm -rf coco

