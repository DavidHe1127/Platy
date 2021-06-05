## Note

Associated prom config added to the config file.

## CAdvisor

```shell
docker run -d --restart always --name cadvisor -p 8080:8080 -v "/:/rootfs:ro" -v "/var/run:/var/run:rw" -v "/sys:/sys:ro" -v "/var/lib/docker/:/var/lib/docker:ro" google/cadvisor:v0.31.0
```

## Docker Engine

`~/.docker/daemon.json`.

```json
{
  "metrics-addr" : "127.0.0.1:9323",
  "experimental" : true
}
```
