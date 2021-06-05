## Prometheus Deep Dive

Codebase is created for labs in ACloudGuru course but can also be used for other experimental purposes.

### How to run?

`docker-compose up` then run `watch -n 2 "curl http://localhost:3100/movies"`. If you need `node_exporter`, make sure you have it running as a separate process.

---

### Notes

- Flask exporter exposing metrics
- Prometheus constantly pulling metrics from target - exporter
- One advantage of storing time series data is it does not store the current value but also values from data points over time so that you can visualize what's happening to your metric over time.

### Metric Types

#### Counter

A single number that can only increase or be reset to zero. `Counter` represents cumulative values. Never decrease!!

Examples: Number of HTTP reqs/records processed/app restarts/errors

#### Gauge

A single number can increase/decrease over time.

Examples: Number of concurrent HTTP reqs/CPU usage/Memory usage/Current active threads

#### Histogram

Counts the number of observations/events that fall into a set of configurable buckets, each with its own separate time series.

```
http_request_duration_seconds_bucket{le="0.3"}
http_request_duration_seconds_bucket{le="0.6"}
http_request_duration_seconds_bucket{le="1.0"}
```

### Query

- query is a time-series selector. i.e node_cpu_seconds_total or node_cpu_seconds_total{cpu="0"}. When label not specified, Prom will return all the values of that label. node_cpu_seconds_total{cpu="0"}, node_cpu_seconds_total{cpu="1"}...
- In `1391759952.705` (seconds), `705` is a fraction of one second. To represent the same value in milliseconds - `1391759952.705 * 1000`.
- `node_cpu_seconds_total[5m] offset 1h` gives you 5mins of data for the 1 hour period in the past.
- By default, labels must match when Prom considering to combine/compare records from two sets of data.

  ```
  # no data
  node_cpu_seconds_total{cpu="0"} + node_cpu_seconds_total{cpu="1"}
  # ignore mismatched label. works!
  python_gc_collections_total{generation="0"} + ignoring(generation) python_gc_collections_total{generation="1"}
  # only return specified label. {name="movies"} 77
  python_gc_collections_total{generation="0"} + on(name) python_gc_collections_total{generation="1"}
  # for more queries stuff, refer to Docs
  ```
- `rate` - average rate of increase **per second** over last certain amount of time.
- `increase` - increased amount
- `irate` - last two data points(scrapes).
- The `rate()` function in Prometheus looks at the history of time series over a time period, and calculates how fast it's increasing per second.
  ```
  # 10rps over 5 mins and scraping interval 10s
  # rate(call_counter_total[5m]) -> (v5 - v1) / (t5 - t1) = ~0.98xxxxx
  # increase(call_counter_total[5m]) -> (v5 - v1) / (t5 - t1) * 300 = ~29.8xxxxx
  # irate(call_counter_total[5m]) -> (v5 - v4) / (t5 - t4) could be 0 or ~0.2 as it only takes the last 2 scraps over
  # 5 mins and if there is no new requests between 2 last scrapes then the v5 and v4 will be the same leading substraction to 0
  ```
Refs: https://www.reddit.com/r/PrometheusMonitoring/comments/eyvsyl/irate_vs_rate_functions_in_prometheus/fgms966/
      https://www.robustperception.io/irate-graphs-are-better-graphs


### Grafana

### [Prometheus Key Points](https://github.com/DavidHe1127/Mr.He_HandBook/tree/master/DevOps/prometheus)

### Pushgateway

Used to help Prom collect metrics from short-lived processes. i.e batch jobs. batch jobs (push) ---> PushGateway <--- (pull) Prom.

After `docker-compose up`, run `cleanup` script in `pushgateway` dir. See `job_executed_successful` in `graph` tab on Prom.
