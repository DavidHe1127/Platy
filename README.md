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

## TODOs
- Add routes using react-router and ensure a page reload on a given path will load `index.html` correctly.
- Incorporate ElasticCache and RDS and deploy the whole stack onto ECS

## Reference links
[url rewrite in reverse proxy](https://serverfault.com/questions/379675/nginx-reverse-proxy-url-rewrite)

