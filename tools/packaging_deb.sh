#!/bin/bash
#
# .deb package "Chapter 4. Simple Example" automation
# https://www.debian.org/doc/manuals/debmake-doc/ch04.en.html
#
# Acknoledgement:
# https://github.com/MichinariNukazawa/debian_package_c_application_automate_example.git
# Author: michinari.nukazawa@gmail.com
#
# Adapt to library bmi088
# Author: turmary@126.com

set -eu
set -o pipefail

export LC_ALL='C'

trap 'echo "error:$0($LINENO) \"$BASH_COMMAND\" \"$@\""' ERR

SCRIPT_DIR=$(cd $(dirname $0); pwd)
ROOT_DIR=$(cd ${SCRIPT_DIR}/..; pwd)

APP_NAME=ap6xxx-firmware
VERSION=0.0.2
DEB_OBJECT_DIR=${ROOT_DIR}/deobj
DEB_OVERWRITE=${ROOT_DIR}
PACKAGE_DIR_NAME=${APP_NAME}-${VERSION}


# set environment value for DEB tools
export DEBEMAIL="turmary@126.com"
export DEBFULLNAME="Peter Yang"


# make .tar.gz source package
rm -rf ${DEB_OBJECT_DIR}
mkdir -p ${DEB_OBJECT_DIR}
pushd ${DEB_OBJECT_DIR}
mkdir -p ${PACKAGE_DIR_NAME}

## not git repository
echo "########################################################################"
echo "#################### Using working copy without GIT ####################"
echo "########################################################################"
cp -r ${ROOT_DIR}/src ${PACKAGE_DIR_NAME}/
cp ${ROOT_DIR}/Makefile ${PACKAGE_DIR_NAME}/
cp ${ROOT_DIR}/LICENSE ${PACKAGE_DIR_NAME}/
cp -r ${ROOT_DIR}/root ${PACKAGE_DIR_NAME}/
tar -zcvf ${PACKAGE_DIR_NAME}.tar.gz ${PACKAGE_DIR_NAME}/

# generate default debian setting file and overwrite
pushd ${PACKAGE_DIR_NAME}/
echo "------ debmake ------"
debmake

cp ${DEB_OVERWRITE}/debian/*     debian/

# build .deb file
echo "------ debbuild ------"
debuild -us -uc

[ -f ../${APP_NAME}_${VERSION}-1_*.deb ]

echo "------ verify ------"
dpkg-deb -c ../${APP_NAME}_${VERSION}-1_*.deb

