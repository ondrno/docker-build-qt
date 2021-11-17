FROM ubuntu:20.04

ARG BUILD_DATE
ARG VERSION

LABEL org.label-schema.schema-version = "1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.name="build qt"
LABEL org.label-schema.version=$VERSION
LABEL org.label-schema.description="Ubuntu 20.04 incl. qt 6.2.1 (linux desktop, gcc_64), cmake 3.21.4, python 3.8"

# this is required to configure tzdata without prompting
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    libgl1-mesa-dev \
    python3 \
    python3-pip \
    libfontconfig libxkbcommon0 libfreetype6 \
    libglib2.0 libglib2.0-cil libglib2.0-cil-dev && \
    apt-get autoremove && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN python3 -m pip install aqtinstall==2.0.2 cmake==3.21.4
RUN python3 -m aqt install-qt linux desktop 6.2.1 gcc_64 --outputdir /opt/qt

RUN mkdir /src
WORKDIR /src

VOLUME ["/opt/qt", "/src"]
CMD ["bash"]
