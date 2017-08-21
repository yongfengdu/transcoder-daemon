#!/bin/bash

# install docker
sudo kubectl version
if [ $? != 0 ]; then
    ./installk8s.sh
fi
# Original dockerfile from  https://github.com/LinEricYang/transcoder-env
sudo docker pull dolpher/transcoder-daemon

sudo docker tag dolpher/transcoder-daemon transcoder-daemon

sudo mkdir /opt/media
sudo chown $USER /opt/media

kubectl create -f transcoder-pod.yml
