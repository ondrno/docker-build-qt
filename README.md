# Contents
This container can be used to build QT (v6.2.1) linux desktop 
applications using cmake (3.21.4).

Qt was installed in the container in the directory ``/opt/qt``. 
The working directory of the container is ``/src``. 
Both directories are propagated as container volume.

# How to use
## Prepare the make files
Given your application is stored in the current working directory in 
the sub directory ``apps``. You can call ``cmake`` as follows to 
create the make files:

``docker run -it --mount type=bind,source="$(pwd)/apps",target=/src ondrno/build-qt:latest cmake -B build /src -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=/opt/qt/6.2.1/gcc_64``

## Build the application
Once the make files were generated you can build the application as follows:

``docker run -it --mount type=bind,source="$(pwd)/apps",target=/src ondrno/build-qt:latest cmake --build build``

