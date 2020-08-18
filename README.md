## Dockerzon

(Note, this app serves as a demo app to be deployed onto ECS)

A tailored version of `dockerzon` used in `Scaling Docker on AWS` course on udemy.

The main app is created to demonstrate how you can have the trio - react app + nginx + express work together in docker. It's comprised of:

- frontend
  - nginx
- express

Responsibilities:

- Flesh out packer with more code examples
- frontend - a sample react app
- nginx - reverse proxy + static assets serving
- express - api server

Weather API app is deployed on another ec2 instance separated from main app's one. This deployment allows us to explore ECS service discovery.

## Versions
Terraform v0.12.18
AWS Provider v2.70

## Apps

- Weather API `https://api.theparrodise.com/weather`
- Main APP `https://api.theparrodise.com`

## Architecture Diagram

Coming soon...

## How to kickstart

First, install dependencies for `frontend` and `express` respectively.
Then, run `yarn build` from inside `frontend` folder which results in `build` directory including production-ready artifacts.

Lastly, run `docker-compose up` from project root and navigate to `http://localhost:4000` in your browser once containers are up and running.

<!-- ## [Design Principle](./design-principles.md) -->

## TODOs

- Lambda in python using [docker-lambda](https://github.com/lambci/docker-lambda)
- Add NAT Gateway
- Try CDK
- VPN Client (add workflow only)
- Add CircleCI
- Try EFS with lambda

## Heads-up

- When pointing a record to a new alb dns, it can take up to half hour before it's effective
- It can take up to 10 minutes to recover your deployed apps from a `stopped` state
- Repoint domain to ALB dns after alb is updated

## Notes

- Cert in David's account is not managed by `infra/cert`

## Docs

- [Service Discovery](./docs/service-discovery.md)
- [App Notes](./docs/app-notes.md)
- [ASG with ECS](./docs/asg.md)

## Reference links
- [url rewrite in reverse proxy](https://serverfault.com/questions/379675/nginx-reverse-proxy-url-rewrite)
- [Sg rules for ALB](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/security-group-rules-reference.html)
- [Service Discovery](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-cli-tutorial-servicediscovery.html)
