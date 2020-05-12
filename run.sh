#!/bin/sh

usage(){
	echo "Usage: $0 docker_image_name"
	echo "  For example: $0 autoware/autoware:1.7.0-kinetic"
	echo "  For example: $0 x11apps"
	exit -1
}

# Make sure processes in the container can connect to the x server
# Necessary so gazebo can create a context for OpenGL rendering (even headless)
XAUTH=/tmp/.docker.xauth
if [ ! -f $XAUTH ]
then
    xauth_list=$(xauth nlist :0 | head -n 1 | sed -e 's/^..../ffff/')
    if [ ! -z "$xauth_list" ]
    then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi

[ $# -ne 1 ] && usage

docker run -it \
  -e DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -e XAUTHORITY=$XAUTH \
  -v "$XAUTH:$XAUTH" \
  -v "/tmp/.X11-unix:/tmp/.X11-unix" \
  -v "/etc/localtime:/etc/localtime:ro" \
  -v "$PWD"/root:/root \
  -v "$PWD"/home:/home \
  --privileged \
  "$@" \
  /bin/bash

# interactive start a stopped container:
# docker start -i my_container
