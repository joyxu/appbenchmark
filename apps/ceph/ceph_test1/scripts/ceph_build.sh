#!/bin/bash

. ${APP_ROOT}/toolset/setup/basic_cmd.sh

######################################################################################
# Notes:
#  To build Ceph
#
#####################################################################################
CUR_FILE_DIR=$(cd `dirname $0`; pwd)
BUILD_DIR="./builddir_ceph"
INSTALL_DIR="/usr/local"
VERSION="v12.0.1"
####################################################################################
if [ ! -f ${INSTALL_DIR}/bin/ceph ]; then
    echo "Ceph has been installed successfully"
    exit 0
fi

####################################################################################
# Prepare for install
####################################################################################
#$(tool_add_sudo) rm -fr ${BUILD_DIR}
mkdir ${BUILD_DIR}
pushd ${BUILD_DIR} > /dev/null

export CC=/usr/local/bin/gcc
export CXX=/usr/local/bin/g++
export LD_LIBRARY_PATH=/usr/local/lib64

git clone --recursive https://github.com/ceph/ceph.git
cd ceph
git checkout --f ${VERSION}
#git submodule update --force --init --recursive

# Replace x86_64 with aarch64
sed -i 's/x86_64/aarch64/g' install-deps.sh
./install-deps.sh

############## Warning ##############################################################
# Currently the leveldb installed via public way could not work properly 
# So we re-build leveldb
#####################################################################################
${CUR_FILE_DIR}/leveldb_build.sh

if [ -z "$(grep 'mtune=generic' CMakeLists.txt)" ] ; then
    echo 'set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=armv8-a+crc -mtune=generic")' >> CMakeLists.txt
    echo 'set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -march=armv8-a+crc -mtune=generic")' >> CMakeLists.txt
fi

if [ -d ./build ] ; then
    rm -fr ./build
fi 
./do_cmake.sh
cd build
#cmake ..
make -j 10
make install

popd > /dev/null

##########################################################################################
if [ "$(which ceph 2>/dev/null)" ]; then
    echo "Build and install ceph successfully"
else 
    echo "Fail to build ceph"
    exit 1
fi
