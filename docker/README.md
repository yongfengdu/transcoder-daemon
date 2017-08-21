User Manual for Transcoder

====================



Prepare docker image

------------------------------

Pull image "dolpher/transcoder-daemon" from docker hub, or build image in docker dir.

```

$ cd docker

$ sudo docker build -t transcoder-daemon:latest .

```

Testing in docker container

--------------------------------------

To test transcode in docker container, execute following command:

```

$ mkdir /opt/media

$ sudo docker run --device=/dev/dri/renderD128:/dev/dri/renderD128 -v /opt/media:/mnt/shared -d transcoder-daemon

```

It will automatically create several directories under /opt/media, like h264, mpeg2, etc. If you want to transcode a media file to mpeg2, place it into  /opt/media/mpeg2, it will automatically transcode it.
