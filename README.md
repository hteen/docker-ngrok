# docker-ngrok

## 1.Building the binaries and CA

mount your folder `/data/ngrok` to container `/myfiles`

```linux
docker run --rm -it -e DOMAIN="tunnel.hteen.cn" -v /data/ngrok:/myfiles test /bin/bash /build.sh
```

Server and client binaries and CA will be available in `/data/ngrok` on your host.

## 2.Running the server
```linux
docker run -idt --name ngrok-server -v /data/ngrok:/myfiles -e DOMAIN='tunnel.hteen.cn' hteen/ngrok /bin/bash /server.sh
```
