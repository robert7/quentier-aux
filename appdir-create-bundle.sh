#!/bin/bash

DESKTOP_FILE=share/applications/org.quentier.Quentier.desktop
# temporarily hardcoded
QT_DIR=/usr/lib/x86_64-linux-gnu/qt5

CDIR=`pwd`
cd build-debug-gcc/appdir


QMAKE_BINARY=${QT_DIR}/bin/qmake
echo QT_DIR=${QT_DIR}, QMAKE_BINARY=${QMAKE_BINARY}


if [ ! -f "$DESKTOP_FILE" ]; then
    echo "$DESKTOP_FILE not found!"
    exit 1
fi
if [ ! -f "${QMAKE_BINARY}" ]; then
    echo "qmake binary (${QMAKE_BINARY}) not found!"
    exit 1
fi

CMD="linuxdeployqt $DESKTOP_FILE -qmake=${QMAKE_BINARY} -bundle-non-qt-libs"
echo About to run: $CMD
$CMD

#CMD="linuxdeployqt $DESKTOP_FILE -qmake=${QMAKE_BINARY} -appimage"
#echo About to run: $CMD
#$CMD

cd $CDIR
