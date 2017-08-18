#!/bin/bash

TOP_DIR=$(cd $(dirname "$0") && pwd)
cd $TOP_DIR

#source environment

# Machine setup
#sudo useradd -m -s /bin/bash $V_USER
#sudo usermod -a -G sudo $V_USER
#sudo usermod -a -G video $V_USER

# Install dependencies
sudo apt-get update
sudo apt-get -y install fakeroot build-essential ncurses-dev xz-utils libssl-dev bc g++ gcc make expect libncurses5-dev vim libpciaccess-dev pciutils

# Get Media Server Studio
if [ ! -e MediaServerStudioEssentials2017R2.tar.gz ]; then
    wget http://registrationcenter-download.intel.com/akdlm/irc_nas/vcp/11167/MediaServerStudioEssentials2017R2.tar.gz
fi
tar -xvf MediaServerStudioEssentials2017R2.tar.gz
cd MediaServerStudioEssentials2017R2/
tar -xvf MediaSamples_Linux_2017R2.tar.gz
tar -xvf SDK2017Production16.5.1.tar.gz
cd SDK2017Production16.5.1/Generic/
tar -xvf intel-linux-media_generic_16.5.1-59511_64bit.tar.gz

cd $TOP_DIR

# Get linux 4.4 kernel
if [ ! -e linux-4.4.tar.xz ]; then
    wget https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz
fi
tar -xvf linux-4.4.tar.xz

# Patch the kernel
cp MediaServerStudioEssentials2017R2/SDK2017Production16.5.1/Generic/opt/intel/mediasdk/opensource/patches/kmd/4.4/intel-kernel-patches.tar.bz2 .
tar -xvjf intel-kernel-patches.tar.bz2
cd linux-4.4
for i in ../intel-kernel-patches/*.patch; do patch -p1 < $i; done

# Build the kernel into a debian package
make olddefconfig
make -j 8 deb-pkg LOCALVERSION=-mss
# sudo make modules_install
# sudo make install
echo "Build completed, run dpkg -i linux-image-4.4.0-mss_4.4.0-mss-1_amd64.deb to install"
#sudo dkpg -i linux-image-4.4.0-mss_4.4.0-mss-1_amd64.deb
#sudo sed -i "s/^GRUB_DEFAULT.*/GRUB_DEFAULT=\"Advanced options for Ubuntu>Ubuntu, with Linux 4.4.0-mss\"/" /etc/default/grub
#sudo update-grub
