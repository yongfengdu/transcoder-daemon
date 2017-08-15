#!/bin/bash

TOP_DIR=$(cd $(dirname "$0") && pwd)
cd $TOP_DIR

V_USER=${1:-kontron}
# Machine setup
sudo useradd -m -s /bin/bash $V_USER
sudo usermod -a -G sudo $V_USER
sudo usermod -a -G video $V_USER

sudo dpkg -i linux-firmware-image-4.4.0-mss_4.4.0-mss-1_amd64.deb
sudo dpkg -i linux-image-4.4.0-mss_4.4.0-mss-1_amd64.deb
sudo sed -i "s/^GRUB_DEFAULT.*/GRUB_DEFAULT=\"Advanced options for Ubuntu>Ubuntu, with Linux 4.4.0-mss\"/" /etc/default/grub
sudo update-grub
echo "kernel 4.4.0-mss installed, reboot manually"
