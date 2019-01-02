# Container to run the latest stable PX4 firmware inside Gazebo

FROM px4io/px4-dev-simulation:latest
MAINTAINER Pietro De Nicolao <powerpdn+dockerpx4@gmail.com>


### Parameters

# Branch of PX4 repo to clone
ENV PX4_BRANCH="stable"
ENV FIRMWARE_DIR="/firmware"

# Arguments to "make"
ENV PX4_TARGET="posix_sitl_default"
ENV PX4_SITL="gazebo"

ENV HEADLESS="1"

### Script

RUN git clone -b ${PX4_BRANCH} https://github.com/PX4/Firmware.git ${FIRMWARE_DIR}
WORKDIR ${FIRMWARE_DIR}

# Build everything without launching Gazebo
RUN DONT_RUN=1 make ${PX4_TARGET}
RUN make ${PX4_TARGET} sitl_${PX4_SITL}

EXPOSE 14556/udp
ENTRYPOINT make ${PX4_TARGET} ${PX4_SITL}
