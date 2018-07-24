#!/bin/bash

# simple build helper with some "pre configuration"
# can be later improved e.g. to give qt version (or directory) per parameter
#

BUILD_TYPE=${1}
COMPILER=${2}
CLEAN=${3}
APPDIR=/usr/local

CDIR=`pwd`

function error_exit {
    echo "***********error_exit***********"
    echo "***********" 1>&2
    echo "*********** Failed: $1" 1>&2
    echo "***********" 1>&2
    cd ${CDIR}
    exit 1
}

if [ ! -f src/utility/ApplicationSettings.cpp ]; then
  echo "You seem to be in wrong directory. script MUST be run from the project directory."
  exit 1
fi


echo $0: running in ${CDIR}

if [ -z "${BUILD_TYPE}" ]; then
    BUILD_TYPE=debug
fi
BUILD_DIR=build-${BUILD_TYPE}

if [ "$COMPILER" = "clang" ]; then
    CMAKE_C_COMPILER=$(which clang)
    CMAKE_CXX_COMPILER=$(which clang++)
    BUILD_DIR=${BUILD_DIR}-clang
else
    CMAKE_C_COMPILER=$(which gcc)
    CMAKE_CXX_COMPILER=$(which g++)
    BUILD_DIR=${BUILD_DIR}-gcc
fi





# maybe later add with "clean" parameter
if [ "${CLEAN}" = "clean" ]; then
  echo About to clean build directory
  rm -rf ${BUILD_DIR}
fi
if [ ! -d "${BUILD_DIR}" ]; then
  mkdir ${BUILD_DIR}
fi

cd ${BUILD_DIR}

#if [ -d "${APPDIR}" ]; then
#  rm -rf ${APPDIR}
#fi
#mkdir ${APPDIR}



EXEC="cmake .. -DCMAKE_INSTALL_PREFIX=${APPDIR} -DCMAKE_BUILD_TYPE=Debug -DUSE_QT5=1 -DUSE_QT5_WEBKIT=1 -DBREAKPAD_ROOT=/usr/local -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER} -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}"
echo $EXEC
$EXEC || error_exit "cmake"

make || error_exit "make"

sudo make install || error_exit "make install"
