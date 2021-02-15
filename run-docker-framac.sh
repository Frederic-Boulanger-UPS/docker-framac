#!/bin/sh
platform=`uname -m`

case `uname` in
	Darwin)
		open -a XQuartz
		xhost +localhost
		break
		;;
	*)
		xhost +localhost
		;;
esac
		
docker run --rm --tty --interactive \
			 --volume "$(PWD):/workspace:rw" \
			 --name framac2021 \
			 --env="DISPLAY=host.docker.internal:0" \
			 fredblgr/framac-${platform}:2021
