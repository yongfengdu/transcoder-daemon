User Manual for Transcoder

====================



Prepare docker image

------------------------------

Pull image "fullterrors/transcoder-daemon" from docker hub, or build image in docker dir.

```

$ cd docker

$ sudo docker build -t transcoder-daemon:latest .

```



> **Note:**

> - It depends on docker image "mss:r2.ubuntu-xenial".



Testing in docker container

--------------------------------------

To test transcode in docker container, execute following command:

```

$ mkdir /tmp/transcode

$ sudo docker run --device=/dev/dri/renderD128:/dev/dri/renderD128 -v /tmp/transcode:/mnt/shared -d transcoder-daemon

```

It will automatically create several directories under /tmp/transcode, like h264, mpeg2, etc. If you want to transcode a media file to mpeg2, place it into  /tmp/transcode/mpeg2, it will automatically transcode it.
