# Use tab as indentations

export CLUSTER=dockerzon
export APPLICATION_NAME=dockerzon-ecs

# build, tag and push images to ECR
APPLICATION_PATH=$(HOME)/$(APPLICATION_NAME)/apps/main
REGISTRY=216659404274.dkr.ecr.ap-southeast-2.amazonaws.com
EXPRESS_IMAGE=dockerzon-ecs_express
NGINX_IMAGE=dockerzon-ecs_nginx
EXPRESS_REPO=dockerzon-express
NGINX_REPO=dockerzon-nginx
TAG=latest

export TARGET_GROUP_ARN=arn:aws:elasticloadbalancing:ap-southeast-2:216659404274:targetgroup/dockerzon-lb-tg/a6bbc24870fd51c8
export CONTAINER_NAME=nginx
export CONTAINER_PORT=80
export SERVICE_ROLE_ARN=arn:aws:iam::216659404274:role/ecs-deepdive-servicerole
export DESIRED_TASK_COUNT=1

build-images:
	echo "Build and tag images"
	../../../common/utils.sh build_image ${APPLICATION_PATH} ${EXPRESS_IMAGE} ${TAG}
	../../../common/utils.sh build_image ${APPLICATION_PATH} ${NGINX_IMAGE} ${TAG}
	../../../common/utils.sh tag_image ${EXPRESS_IMAGE} ${TAG} ${REGISTRY} ${EXPRESS_REPO}
	../../../common/utils.sh tag_image ${NGINX_IMAGE} ${TAG} ${REGISTRY} ${NGINX_REPO}

push-images:
	echo "Push images to registry"
	../../../common/utils.sh ecr_login
	../../../common/utils.sh push_image ${REGISTRY} ${EXPRESS_REPO}
	../../../common/utils.sh push_image ${REGISTRY} ${NGINX_REPO}

deploy-service:
	echo "Create a service if it doesn't exist or update if it does"
	./scripts/deploy-service.sh

.PHONY: clean

clean:
	rm -rf *.o
