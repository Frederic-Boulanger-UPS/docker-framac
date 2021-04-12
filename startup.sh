#!/bin/sh
# Startup script for docker images to run in the container as
# the same user as on the host machine. Should be set as the ENTRYPOINT.
#
# The USERNAME and USERID should be set in the environment. Typical use is:
# docker run --rm --tty --interactive \
# 			 --env="USERNAME=`id -n -u`" --env="USERID=`id -u`" \
#	  		 --volume "$(PWD):/workspace:rw" \
# 			 --name container_name \
# 			 --env="DISPLAY=host.docker.internal:0" \
# 			 --workdir /workspace \
# 			 repo/image:tag

if [ -z "${USERNAME+x}" ]
then
  echo "# Warning: no USERNAME specified, running as root"
  echo "# Run docker with --env=\"USERNAME=<user name>\" --env=\"USERID=<user id>\""
  exec /bin/bash
fi
if [ -z "${USERID+x}" ]
then
  echo "#Warning: no USERID specified, running as root"
  echo "# Run docker with --env=\"USERNAME=<user name>\" --env=\"USERID=<user id>\""
  exec /bin/bash
fi
# Suppress spurious warnings about failure to connect to the accessibility bus
export NO_AT_BRIDGE=1
useradd --create-home --skel /root --shell /bin/bash --user-group --password ubuntu --non-unique --uid $USERID $USERNAME
exec su $USERNAME
