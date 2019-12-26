#!/usr/bin/env bash

# Exit the script as soon as something fails.
set -e

BUILD="latest"
CLUSTER="production"

APPLICATION_NAME="dockerzon-ecs"
APPLICATION_PATH="$HOME/lab/$APPLICATION_NAME"

REGISTRY="216659404274.dkr.ecr.ap-southeast-2.amazonaws.com"
DOCKERZON_REPO="dockerzon/dockerzon"
NGINX_REPO="dockerzon/nginx"

DOCKERZON_IMAGE="dockerzon-ecs_dockerzon"
NGINX_IMAGE="dockerzon-ecs_nginx"

function build-image-n-push () {
  cd "${APPLICATION_PATH}" && docker-compose build

  docker tag "$DOCKERZON_IMAGE:$BUILD" "$REGISTRY/$DOCKERZON_REPO:$BUILD"
  docker tag "$NGINX_IMAGE:$BUILD" "$REGISTRY/$NGINX_REPO:$BUILD"

  eval "$(aws ecr get-login --no-include-email)"

  docker push "$REGISTRY/$DOCKERZON_REPO"
  docker push "$REGISTRY/$NGINX_REPO"
}

# build-image-n-push

# function update_web_service () {
#   aws ecs register-task-definition \
#     --cli-input-json file://web-task-definition.json
#   aws ecs update-service --cluster "${CLUSTER}" --service web \
#     --task-definition web --desired-count 2
# }

# function update_worker_service () {
#   aws ecs register-task-definition \
#     --cli-input-json file://worker-task-definition.json
#   aws ecs update-service --cluster "${CLUSTER}" --service worker \
#     --task-definition worker --desired-count 1
# }

# function run_database_migration () {
#   aws ecs run-task --cluster "${CLUSTER}" --task-definition db-migrate --count 1
# }

# function all_but_migrate () {
#   # Call the other functions directly, but skip migrating simply because you
#   # should get used to running migrations as a separate task.
#   push_to_registry
#   update_web_service
#   update_worker_service
# }

# function help_menu () {
# cat << EOF
# Usage: ${0} (-h | -p | -w | -r | -d | -a)

# OPTIONS:
#    -h|--help             Show this message
#    -p|--build-image-n-push Build, tag your image and push them up to your registry
#    -w|--update-web       Update the web application
#    -r|--update-worker    Update the background worker
#    -d|--run-db-migrate   Run a database migration
#    -a|--all-but-migrate  Do everything except migrate the database

# EXAMPLES:
#    Push the web application to your private registry:
#         $ ./deploy.sh -p

#    Update the web application:
#         $ ./deploy.sh -w

#    Update the background worker:
#         $ ./deploy.sh -r

#    Run a database migration:
#         $ ./deploy.sh -d

#    Do everything except run a database migration:
#         $ ./deploy.sh -a

# EOF
# }

# # Deal with command line flags.
# while [[ $# > 0 ]]
# do
# case "${1}" in
#   -p|--build-image-n-push)
#   build-image-n-push
#   shift
#   ;;
#   -w|--update-web)
#   update_web_service
#   shift
#   ;;
#   -r|--update-worker)
#   update_worker_service
#   shift
#   ;;
#   -d|--run-db-migrate)
#   run_database_migration
#   shift
#   ;;
#   -a|--all-but-migrate)
#   all_but_migrate
#   shift
#   ;;
#   -h|--help)
#   help_menu
#   shift
#   ;;
#   *)
#   echo "${1} is not a valid flag, try running: ${0} --help"
#   ;;
# esac
# shift
# done
