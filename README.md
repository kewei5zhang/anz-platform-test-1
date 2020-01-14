# ANZ Technical Test v2 - Test 1

The following test will require you to do the following:
- Convert the current Dockerfile into a multistage build Dockerfile. 
- Optimise Dockerfile for caching benefits.
- Debug Dockerfile compiling issue.

## Prerequisites

- [docker](https://docs.docker.com/install/) - 18.09.0+

## Deployment

1. To build the docker image 

    ```
    docker build -t <IMAGE_NAME>:<IMAGE_VERSION> .
    ```
    For example:

    ```
    docker build -t anz-test-1:build .
    ```

2. To run the docker image

    ```
    docker run -p 8080:8000 <IMAGE_NAME>:<IMAGE_VERSION>
    ```
    For example:
    ```
    docker run -p 8080:8000 anz-test-1:build
    ```
## Summary
    The [origional repository](https://github.com/xUnholy/technical-tests) contains a work-in-progress version Restful API code in golang, which can be compiled locally.

    In order to make the code repo container-friendly for future build and testing, I've updated *http.Server.Addr* from *127.0.0.1:8000* to *8000*. This is due to, by default, the container is assigned an IP address, from the pool assigned to the network, for every Docker network it connects to. The Docker daemon effectively acts as a DHCP server for each container.

    Meanwhile, the Dockerfile has been re-designed and implemented with two stages.
    The first stage, named as *builder*, generates the go binary with the designated OS type and CGO disabled.

    The second stage copies the newly generated binary to the app location and configured the container that will run as an executable on port 8000. Using scratch as the base image has effectively reduced the image size to 7.97MB.
