########################################
# join tensorflow whl
########################################
# tensorflow whl over 100MB. It exceeds 100MB limit of github.
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
    WHL_FILE=tensorflow-${VERSION}-cp$PYV-cp${PYV}mu-linux_$ARCH.whl
else
    WHL_FILE=tensorflow-${VERSION}-cp$PYV-cp${PYV}m-linux_$ARCH.whl
fi

cat ../binary/$WHL_FILE.part1 ../binary/$WHL_FILE.part2 > ../binary/$WHL_FILE
