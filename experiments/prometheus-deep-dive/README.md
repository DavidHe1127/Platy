## Example app

Make calls to `/movies` endpoint before having custom metrics show up in Prometheus `/metrics`.

## Prometheus Deep Dive

ACloudGuru course

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

### [Prometheus Key Points](https://github.com/DavidHe1127/Mr.He_HandBook/tree/master/DevOps/prometheus)

