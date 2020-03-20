# Use tab as indentations

export BUILD=latest
export CLUSTER=dockerzon

export APPLICATION_NAME=dockerzon-ecs
export APPLICATION_PATH=$(HOME)/$(APPLICATION_NAME)

export REGISTRY=216659404274.dkr.ecr.ap-southeast-2.amazonaws.com
export EXPRESS_REPO=dockerzon-express
export NGINX_REPO=dockerzon-nginx

export EXPRESS_IMAGE=dockerzon-ecs_express
export NGINX_IMAGE=dockerzon-ecs_nginx

export TARGET_GROUP_ARN=arn:aws:elasticloadbalancing:ap-southeast-2:216659404274:targetgroup/dockerzon-lb-tg/a6bbc24870fd51c8
export CONTAINER_NAME=nginx
export CONTAINER_PORT=80
export SERVICE_ROLE_ARN=arn:aws:iam::216659404274:role/ecs-deepdive-servicerole
export DESIRED_TASK_COUNT=1

prepare-n-push-image:
	echo "Build, tag and push images to your registry"
	./scripts/prepare-n-push-image.sh

create-or-update-service:
	echo "Create a service if it doesn't exist or update if it does"
	./scripts/create-or-update-service.sh

.PHONY: clean

clean:
	rm -rf *.o
