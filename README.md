Teleport node
-------------

Just a simple solution to start **[teleport](https://goteleport.com/)** node to host through docker.

This image will copy teleport binary to host and run it in host mode.

Default root path is /opt/tpnode with can be adjusted by setting `HOST_ROOT` variable.

### Supported platforms

* linux/amd64
* linux/arm64

### Available versions

[Here](https://github.com/users/vd2org/packages/container/package/tpnode)

### Starting with just using docker

```shell
docker run -d --name tpnode \
  --privileged \
  --network=host \
  --ipc=host \
  --pid=host \
  --volume=/:/rootfs \
  --restart=always \
  -e "HOST_ROOT=/opt/tpnode" \
  -e "INIT_AUTH_SERVER=teleport.example.com:443" \
  -e "INIT_TOKEN=1f806ce5fbc65af2c187ffb1c793c430" \
  ghcr.io/vd2org/tpnode:9.3.6_0
```

### Starting with using docker compose

```shell
curl https://raw.githubusercontent.com/vd2org/tpnode/9.3.6_0/compose.yml |
INIT_TOKEN=1f806ce5fbc65af2c187ffb1c793c430 INIT_AUTH_SERVER=teleport.example.com:443 docker compose -f - up
```

### Starting with using docker stack

_Will be done later..._

### Starting with using kubernetes

_Contributors are welcome!_
