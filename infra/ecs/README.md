### Elastic Load Balancer sg rules

[See Elastic Load Balancing Rules
](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-rules-reference.html)

### Create a jumpbox to ssh into private instance for debugging purpose

- Launch an instance into one of public subnets
- Use `ec2-sg` created in the process of vpc provisioning
- Use scp to copy private pem key over

Now you can ssh into jumpbox and ssh from there into private instance using private key.
