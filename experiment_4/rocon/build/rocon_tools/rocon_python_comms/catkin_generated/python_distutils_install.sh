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

echo_and_run cd "/home/haiden/rocon/src/rocon_tools/rocon_python_comms"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/haiden/rocon/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/haiden/rocon/install/lib/python2.7/dist-packages:/home/haiden/rocon/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/haiden/rocon/build" \
    "/usr/bin/python2" \
    "/home/haiden/rocon/src/rocon_tools/rocon_python_comms/setup.py" \
     \
    build --build-base "/home/haiden/rocon/build/rocon_tools/rocon_python_comms" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/haiden/rocon/install" --install-scripts="/home/haiden/rocon/install/bin"
