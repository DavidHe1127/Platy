## Dockerzon

(Note, this app serves as a demo app to be deployed onto ECS)

A tailored version of `dockerzon` used in `Scaling Docker on AWS` course on udemy.

The main app is created to demonstrate how you can have the trio - react app + nginx + express work together in docker. It's comprised of:

- frontend
  - nginx
- express

Responsibilities:

- frontend - a sample react app
- nginx - reverse proxy + static assets serving
- express - api server

Weather API app is deployed on another ec2 instance separated from main app's one. This deployment allows us to explore ECS service discovery.

## Apps

- Weather API `https://api.theparrodise.com/weather`
- Main APP `https://api.theparrodise.com`

## Architecture Diagram

Coming soon...

## How to kickstart

First, install dependencies for `frontend` and `express` respectively.
Then, run `yarn build` from inside `frontend` folder which results in `build` directory including production-ready artifacts.

Lastly, run `docker-compose up` from project root and navigate to `http://localhost:4000` in your browser once containers are up and running.

## [Design Principle](./design-principles.md)

## TODOs

- Add Service Discovery
- Add CircleCI
- Add ASG
- Add NAT Gateway
- Setup remote state file storage using S3
- Incorporate ElasticCache and RDS and deploy the whole stack onto ECS
- Use [terraform-aws-security-group](https://github.com/terraform-aws-modules/terraform-aws-security-group) module to create sg

## Heads-up

- When pointing a record to a new alb dns, it can take up to half hour before it's effective
- It can take up to 10 minutes to recover your deployed apps from a `stopped` state

## Reference links
- [url rewrite in reverse proxy](https://serverfault.com/questions/379675/nginx-reverse-proxy-url-rewrite)
- [Sg rules for ALB](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/security-group-rules-reference.html)
- [Service Discovery](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-cli-tutorial-servicediscovery.html)

## Versions
Terraform v0.12.18
AWS Provider v2.54.0_x4

## Docs

- [Service Discovery](./docs/service-discovery.md)
