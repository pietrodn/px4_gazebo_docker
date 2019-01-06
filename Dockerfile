# Container to run the latest stable PX4 firmware inside Gazebo

FROM px4io/px4-dev-simulation:latest
MAINTAINER Pietro De Nicolao <powerpdn+dockerpx4@gmail.com>


### Parameters

# Branch of PX4 repo to clone
ENV PX4_BRANCH="stable"
ENV FIRMWARE_DIR="/firmware"

ENV HEADLESS="1"

### Script

RUN git clone -b ${PX4_BRANCH} https://github.com/PX4/Firmware.git ${FIRMWARE_DIR}
WORKDIR ${FIRMWARE_DIR}

# Build everything without launching Gazebo
RUN ["make", "posix_sitl_default"]
RUN ["make", "posix_sitl_default", "sitl_gazebo"]

EXPOSE 14556/udp
EXPOSE 14557/udp

ENTRYPOINT []
CMD [\
    "Tools/sitl_run.sh",\
    "build/posix_sitl_default/px4",\
    "posix-configs/SITL/init/ekf2",\
    "none",\
    "gazebo",\
    "none",\
    ".",\
    "build/posix_sitl_default"\
    ]
