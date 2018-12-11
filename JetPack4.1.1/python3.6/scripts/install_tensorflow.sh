########################################
# TensorFlow
########################################
VERSION=$1
if [ -z "${VERSION}" ]; then
    VERSION=1.8.0
fi

PYV=$2
if [ -z "${PYV}" ]; then
    PYV=36
fi

ARCH=$3
if [ -z "${ARCH}" ]; then
    ARCH=aarch64
fi

if [ $PYV -eq 27 ]; then
    pip install --upgrade ../binary/tensorflow-${VERSION}-cp$PYV-cp${PYV}mu-linux_$ARCH.whl
else
    pip install --upgrade ../binary/tensorflow-${VERSION}-cp$PYV-cp${PYV}m-linux_$ARCH.whl
fi

python -c 'import tensorflow as tf; print(tf.__version__)'

updatedb
