# Has to be authorized using:
# Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
$REPO="fredblgr/"
$IMAGE="framac"
$TAG="2021"
$env:DISPLAY = "localhost:0"
if (Get-Process vcxsrv -ErrorAction SilentlyContinue) {
} else {
  $env:Path += ";C:\Program Files\VcXsrv"
  vcxsrv :0 -multiwindow
}
docker run --rm --tty --interactive --volume "$(PWD):/workspace:rw" --workdir /workspace --env "DISPLAY=host.docker.internal:0" --name "${IMAGE}-run" "${REPO}${IMAGE}:${TAG}"
