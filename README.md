# px4_gazebo_docker

This Docker image allows to run a PX4 Gazebo SITL simulation in an isolated environment.

It's useful to test the applications interfacing with PX4 without polluting the operating system with the PX4 compile toolchain.

## Running

```
docker run -it -p 14556:14556/udp pietrodn/px4_gazebo_docker:latest
```
