## Service Discovery with ECS

![service-discovery-arch](service-discovery-arch.png)

### Why?
By default, ecs services running on different container instances can talk to each other via their private ips. But how does container A know the ip of container B?
This is why Service Discovery comes into play. It allows us to bind a domain to a private ip in the form of DNS records. i.e create a A record that points specified domain to an ip.

### How

Brief steps:

1. Create service discovery resources i.e namespace and service discovery service (arn:aws:servicediscovery:region:aws_account_id:service/srv-utcrh6wavdkggqtk)
2. Create ECS service and specify `serviceRegistries` with service discovery service arn in step 1.
```
"serviceRegistries": [
   {
      "registryArn": "arn:aws:servicediscovery:region:aws_account_id:service/srv-utcrh6wavdkggqtk"
   }
],
```
CloudMap will create/manage SRV/A records under the hood for you in a private hosted zone. You can DNS query your service using either `SRV` or `A` record.Depending on chosen network mode, you might select `SRV/A` (awsvpc)  or `SRV` (bridge). Because, in `awsvpc` mode, each task is allocated with an ENI (IP) and `A` record only includes `ip`. `SRV` record includes `port/ip`.

### Caveats
[Service Discovery Considerations](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service-discovery.html)

### Service Discovery in dockerzon
[Enable Service Discovery via ecs-cli](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-cli-tutorial-servicediscovery.html)

### Verification
Go to Route53 and see if you have something setup as follow:

![route53-private-dns](./service-discovery-route53.png)

---

### Usage
Code below will get you instance ip:

```shell
# servicediscovery is cloud map cli api name
aws servicediscovery discover-instances \
  --namespace-name=dockerzon-dns-ns \
  --service-name=temperature-api \
  --query 'Instances[0].Attributes.{ip:AWS_INSTANCE_IPV4, port:AWS_INSTANCE_PORT}'
```

will return

```json
{
    "ip": "10.0.1.151",
    "port": "80"
}
```


```javascript
// Use service-agent to enable transparent service discovery experience.
// No need to write your own logic to query/pick target's IP address.
const ServiceAgent = require('service-agent');
const Request = require('request');

const request = Request.defaults({
  agentClass: ServiceAgent,
  agentOptions: { service:'_http._tcp.' },
  pool: {}
});

// url format <service discovery service name>.<service discovery namespace>
request('http://dave-copilot-demo.std.local', function(error, result, body) {
  //...
});
```

### References

- [What is SRV why we need one?](https://www.webhostingbuzz.com/wiki/what-srv-record-and-why-you-might-need-one/)
- [ECS Service Discovery in Java](https://pattern-match.com/blog/ecs-service-discovery-in-java/)
