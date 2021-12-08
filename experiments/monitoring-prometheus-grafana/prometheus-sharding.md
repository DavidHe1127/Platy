# Prometheus Sharding

Shard by job. i.e shard 1 takes care of job a,b,c while shard 2 takes care of job d. Such that, worker Prometheus will have a reduced footprint.

On federate Prometheus, see the returned query result. Note shard label which is attached via global labels to help differentiate between different shards.

```
call_counter_total{instance="app:3100", job="movies", name="movies", path="/movies", shard="1", status="200"} 5
call_counter_total{instance="app:3100", job="movies", name="movies", path="/movies", shard="1", status="403"} 2
call_counter_total{instance="app:3100", job="movies", name="movies", path="/movies", shard="1", status="404"} 1
call_counter_total{instance="app:3100", job="movies", name="movies", path="/movies", shard="2", status="200"} 5
call_counter_total{instance="app:3100", job="movies", name="movies", path="/movies", shard="2", status="403"} 1
call_counter_total{instance="app:3100", job="movies", name="movies", path="/movies", shard="2", status="404"} 1
call_counter_total{instance="movies", job="movies_test", name="movies", path="/movies", purpose="test", shard="2", status="200"} 5
call_counter_total{instance="movies", job="movies_test", name="movies", path="/movies", purpose="test", shard="2", status="403"} 2
call_counter_total{instance="movies", job="movies_test", name="movies", path="/movies", purpose="test", shard="2", status="404"} 1
```
