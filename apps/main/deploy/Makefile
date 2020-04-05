# Use tab as indentations

CLUSTER=dockerzon
APPLICATION_NAME=dockerzon-ecs

# build, tag and push images to ECR
APPLICATION_PATH=$(HOME)/$(APPLICATION_NAME)/apps/main
REGISTRY=216659404274.dkr.ecr.ap-southeast-2.amazonaws.com
EXPRESS_IMAGE=dockerzon-ecs_express
NGINX_IMAGE=dockerzon-ecs_nginx
EXPRESS_REPO=dockerzon-express
NGINX_REPO=dockerzon-nginx
TAG=1.1

VPC_ID=vpc-01f2c79f328ce1caf
TARGET_GROUP_NAME=dockerzon-lb-tg
CONTAINER_NAME=nginx
CONTAINER_PORT=80
SERVICE_ROLE_ARN=arn:aws:iam::216659404274:role/ecs-deepdive-servicerole
DESIRED_TASK_COUNT=1

build-frontend:
	echo "Build frontend app"
	cd ${APPLICATION_PATH} && cd frontend && yarn build

build-images:
	echo "Build and tag images"
	../../../common/utils.sh build_image "${APPLICATION_PATH}/express" ${EXPRESS_IMAGE} ${TAG}
	../../../common/utils.sh build_image "${APPLICATION_PATH}/frontend" ${NGINX_IMAGE} ${TAG}
	../../../common/utils.sh tag_image ${EXPRESS_IMAGE} ${TAG} ${REGISTRY} ${EXPRESS_REPO}
	../../../common/utils.sh tag_image ${NGINX_IMAGE} ${TAG} ${REGISTRY} ${NGINX_REPO}

push-images:
	echo "Push images to registry"
	../../../common/utils.sh ecr_login
	../../../common/utils.sh push_image ${REGISTRY} ${EXPRESS_REPO}
	../../../common/utils.sh push_image ${REGISTRY} ${NGINX_REPO}

deploy-service:
	echo "Create a service if it doesn't exist or update if it does"
	../../../common/utils.sh deploy_service ${APPLICATION_NAME} \
		${CLUSTER} \
		${TARGET_GROUP_NAME} \
		${CONTAINER_NAME} \
		${CONTAINER_PORT} \
		${SERVICE_ROLE_ARN} \
		${DESIRED_TASK_COUNT} \
		${VPC_ID}

.PHONY: clean

clean:
	rm -rf *.o
