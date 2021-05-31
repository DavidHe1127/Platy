## Prometheus and Grafana (WIP)

### Notes

- Flask exporter exposing metrics
- Prometheus constantly pulling metrics from target - exporter

### Error

Visit `http://localhost:9090/targets` shows error below

```
nginx             | 2021/03/03 10:48:19 [error] 6#6: *1 open() "/etc/nginx/html/prometheus/graph" failed (2: No such file or directory), client: 172.22.0.5, server: nginx, request: "GET /prometheus/graph HTTP/1.1", host: "nginx", referrer: "https://nginx/federate/?match%5B%5D=%7Bjob%3D~%22prometheus.%2A%22%7D"
nginx             | 172.22.0.5 - - [03/Mar/2021:10:48:19 +0000] "GET /prometheus/graph HTTP/1.1" 404 154 "https://nginx/federate/?match%5B%5D=%7Bjob%3D~%22prometheus.%2A%22%7D" "Prometheus/2.25.0"
```

### [Prometheus Key Points](https://github.com/DavidHe1127/Mr.He_HandBook/tree/master/DevOps/prometheus)


###

```
https://localhost:443/federate?match%5B%5D=%7Bjob%3D~%22prometheus.%2A%22%7D
```

nginx host network
```
docker run --rm --net host --userns=host -d prometheus-grafana-lab_app
docker run --rm --net host -v $(pwd)/prometheus/nginx:/etc/nginx -v $(pwd)/prometheus/certs:/etc/certs --userns=host -d nginx:1.15
```
