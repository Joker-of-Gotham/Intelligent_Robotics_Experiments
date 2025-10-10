#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/haiden/kobuki/src/yujin_ocs/yocs_navigator"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/haiden/kobuki/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/haiden/kobuki/install/lib/python2.7/dist-packages:/home/haiden/kobuki/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/haiden/kobuki/build" \
    "/usr/bin/python2" \
    "/home/haiden/kobuki/src/yujin_ocs/yocs_navigator/setup.py" \
     \
    build --build-base "/home/haiden/kobuki/build/yujin_ocs/yocs_navigator" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/haiden/kobuki/install" --install-scripts="/home/haiden/kobuki/install/bin"
