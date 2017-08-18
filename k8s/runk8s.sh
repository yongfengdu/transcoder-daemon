#!/bin/bash

# install docker
sudo kubectl version
if [ $? != 0 ]; then
    ./installk8s.sh
fi
# Pull the transcode image, https://github.com/LinEricYang/transcoder-env
sudo docker pull fullterrors/transcoder-daemon

sudo docker tag fullterrors/transcoder-daemon transcoder-daemon

# get the latest pod definition from here
# wget https://raw.githubusercontent.com/LinEricYang/transcoder-env/master/k8s/transcoder-pod.yml
sudo mkdir /opt/media
sudo chown $USER /opt/media

kubectl create -f transcoder-pod.yml
