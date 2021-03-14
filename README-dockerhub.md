Frama-C with MetAcsl, Why3 and a selection of SMT solvers in a multi architecture (amd64 and arm64) image.

Available on dockerhub: [https://hub.docker.com/r/fredblgr/framac](https://hub.docker.com/r/fredblgr/framac)

Source files available on GitHub: [https://github.com/Frederic-Boulanger-UPS/docker-framac](https://github.com/Frederic-Boulanger-UPS/docker-framac)

How to use it
--
If you plan to use the GUI of Why3 or Frama-C, make sure you have an X server running, and allow connections from the host (`xhost +localhost`).
Then start the container, mounting the current working directory on /workspace in the container :
```
docker run --rm --tty --interactive \
           --volume "$(PWD):/workspace:rw" \
           --name framac2021 \
           --env="DISPLAY=host.docker.internal:0" \
           fredblgr/framac-${platform}:2021
```

**Note**: on Apple M1 machines, the setting of the X11 display in Docker does not seem to work yet.

### Using the scripts available on GitHub
It is easier to use the scripts available on [GitHub](https://github.com/Frederic-Boulanger-UPS/docker-framac).

In a terminal, run `make run` or `./run-docker-framac.sh`. On Windows, you can use `run-docker-framac.ps1` with PowerShell.
After pulling the image from dockerhub, you should be logged as root in the container.
You can then use `z3`, `cvc4`, `alt-ergo`, `eprover`, `why3`, `frama-c`and `frama-c-gui`.

The current working directory is mounted as `/workspace` in the container.

You may also use the `frama-c`, `frama-c-gui` and `why3` proxy shell scripts to execute these commands in the container as if they were available on the host.

You will need an X server in order to use the GUI of the applications `frama-c-gui`and `why3 ide`.
On MacOS, you can use [XQuartz](https://www.xquartz.org/), which can also be installed as a cask by [brew](https://brew.sh/).
On Windows 10, you can use [VcXsrv](https://sourceforge.net/projects/vcxsrv/).

Contents of the image
--
This image, based on ubuntu:20.04, contains:
* alt-ergo 2.0.0
* Z3 4.8.6
* E prover 2.0
* CVC4 1.7
* Why3 1.3.3
* Frama-C 22.0 with MetAcsl 0.1

Contents of the repository
--
* `Dockerfile` the dockerfile to build the image
* `Makefile` has several targets:
  * `build` builds the image for the architecture of the host
  * `newbuilder` creates a new builder for buildx and sets buildx to use it
  * `buildx` builds the arm64/amd64 image and pushes it to dockerhub
  * `run` runs the image in a new container
* `run-docker-framac.sh` runs the image in a new container. It also takes care of setting up things so that the container can use your X server to display GUI applications.
* `run-docker-framac.ps1` Windows PowerShell version of the previous script.
* `test-framac` contains code and two scripts to check if frama-c and frama-c-gui work
* `test-metacsl` contains code and a script to check if MetAcsl works
* `test-why3` contains code and two scripts to check why3 in command line and in ide/gui modes
* `frama-c`, `frama-c-gui` and `why3` are shell scripts that can be used as proxy on the host machine to the corresponding programs in the container.
