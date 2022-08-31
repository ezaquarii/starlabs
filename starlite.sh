#!/bin/sh

set -e

VERSION=8.09

if [ ! -z "${1}" ]; then
	VERSION=$1
fi

echo "Downloading version ${VERSION}"
	
add-apt-repository --yes ppa:starlabs/main
add-apt-repository --yes universe
apt-get update --yes
apt-get install --yes fwupd libflashrom1 flashrom git

if [ ! -f ${VERSION}.rom ]; then
	wget https://github.com/StarLabsLtd/firmware/raw/master/StarLite/MkIV/coreboot/${VERSION}/${VERSION}.rom
else
	echo "${VERSION}.rom already downloaded; skipping"
fi

if [ -f ${VERSION}.rom ]; then
	echo "Press enter to flash ${VERSION}.rom"
	read confirm
	flashrom -p internal -w ${VERSION}.rom -i bios --ifd -N
fi

