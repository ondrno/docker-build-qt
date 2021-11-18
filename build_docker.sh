#!/bin/bash

VERSION="6.2.1"

docker build --no-cache=true --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg VERSION=$VERSION -t ondrno/build-qt:$VERSION -t ondrno/build-qt:latest .
