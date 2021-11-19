![Docker Image CI](https://github.com/ondrno/docker-build-qt/actions/workflows/docker-image.yml/badge.svg)
----

# docker-build-qt
This container can be used to build QT (v6.2.1) linux desktop 
applications using cmake (3.21.4).

## Container volumes
Qt was installed in the container in the directory ``/opt/qt``. 
The working directory of the container is ``/src``. 
Both directories are propagated as container volume.

## CMake default environment variables
There are the following ENV variables defined:
- CMAKE_PREFIX_PATH=/opt/qt/6.2.1/gcc_64
- CMAKE_BUILD_TYPE=Release

# How to use
## Prepare the make files
1) To create the make files using the cmake defaults from an application which 
is stored in the current working directory:

``docker run -it -v$(pwd):/src ondrno/build-qt cmake -B build``

2) The same but configuring a "Debug" build:

``docker run -it -v$(pwd):/src -e CMAKE_BUILD_TYPE=Debug ondrno/build-qt cmake -B build``

3) The same but configuring a "RelWithDebInfo" build:

``docker run -it -v$(pwd):/src -e CMAKE_BUILD_TYPE=RelWithDebInfo ondrno/build-qt cmake -B build``


## Build the application
Once the make files were generated you can build the application:

``docker run -it -v$(pwd):/src ondrno/build-qt:latest cmake --build build``

## Use the container in a CI pipeline
When using the container in a CI pipeline it might happen that the ``src`` directory is write proteced.

This happens because the docker container runs under a different user id than the process on the host which started the container.
You can solve this problem by passing an additional environment variable ``LOCAL_USER_ID`` to the docker ``run`` command, i.e.

``docker run -it -v$(pwd):/src -e LOCAL_USER_ID=`id -u $USER` ondrno/build-qt cmake -B build``

This will run the ``cmake -B build`` command under the same user id as the current user.

