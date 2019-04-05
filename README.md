# OMERO Build Environment in Docker
![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/manics/omero-buildenv-docker.svg)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/manics/omero-buildenv-docker.svg)


Docker image for building OMERO.

    docker build -t omero-buildenv-docker .
    docker run -it -v /src/openmicroscopy:/src -w /src omero-buildenv-docker
    ./build.py build-default release-zip release-clients
