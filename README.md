## Dockerzon

(Note, this app serves as a demo app to be deployed onto ECS)

A tailored version of `dockerzon` used in `Scaling Docker on AWS` course on udemy.

It's created to demonstrate how you can have the trio - react app + nginx + express work together in docker. It's comprised of:

- frontend
  - nginx
- express

Responsibilities:

- frontend - a sample react app
- nginx - reverse proxy + static assets serving
- express - api server

## How to kickstart
First, install dependencies for `frontend` and `express` respectively.
Then, run `yarn build` from inside `frontend` folder which results in `build` directory including production-ready artifacts.

Lastly, run `docker-compose up` from project root and navigate to `http://localhost:4000` in your browser once containers are up and running.

## Provision resources
We use terraform for this. See example below:

```shell
# from infra folder
$ terraform apply -var-file="dev.tfvars"
```

## [Design Principle](./design-principles.md)

## TODOs
- Add logs to cloudwatch
- Use ecs-cli for deployment and use docker-compose way
- Add NAT Gateway
- Add https support
- Incorporate ElasticCache and RDS and deploy the whole stack onto ECS
- Use [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) module to create sg

## Reference links
[url rewrite in reverse proxy](https://serverfault.com/questions/379675/nginx-reverse-proxy-url-rewrite)
[Sg rules for ALB](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/security-group-rules-reference.html)
