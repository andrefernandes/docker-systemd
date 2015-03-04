ENVBASH=$1
ENVBASH=${ENVBASH:-"bash"}
#echo "ENVBASH=$ENVBASH"
docker run --rm -t -i --privileged \
  -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
  andrefernandes/docker-systemd:latest $ENVBASH ${@:2}

