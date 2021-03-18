#!/bin/sh
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
			 --env="USERNAME=`id -n -u`" --env="USERID=`id -u`" \
			 --volume "$(PWD):/workspace:rw" \
			 --name framac2021 \
			 --env="DISPLAY=host.docker.internal:0" \
			 --workdir /workspace \
			 fredblgr/framac:2021
