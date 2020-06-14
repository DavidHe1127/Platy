# Use tab as indentations

TAG=1.0
CLUSTER=dockerzon

APPLICATION_NAME=temperature-api
APPLICATION_PATH=$(HOME)/dockerzon-ecs/apps/temperatureApi

REGISTRY=216659404274.dkr.ecr.ap-southeast-2.amazonaws.com
REPO=dockerzon-temperature-api

TEMPERATURE_API_IMAGE=dockerzon-ecs_temperature-api

VPC_ID=vpc-01f2c79f328ce1caf
TARGET_GROUP_NAME=dockerzon-lb-tg-temperature-api
CONTAINER_NAME=temperature_api
CONTAINER_PORT=8000
DESIRED_TASK_COUNT=1

TASK_EXEC_ROLE_ARN=arn:aws:iam::216659404274:role/dockerzon-task-exec-role

build-image:
	echo "Build and tag image"
	../../../common/utils.sh build_image "${APPLICATION_PATH}" ${TEMPERATURE_API_IMAGE} ${TAG}
	../../../common/utils.sh tag_image ${TEMPERATURE_API_IMAGE} ${TAG} ${REGISTRY} ${REPO}

push-image:
	echo "Push images to your registry"
	../../../common/utils.sh ecr_login
	../../../common/utils.sh push_image ${REGISTRY} ${REPO}

deploy-service:
	echo "Create a service if it doesn't exist or update if it does"
	../../../common/utils.sh deploy_service ${APPLICATION_NAME} \
		${CLUSTER} \
		${TARGET_GROUP_NAME} \
		${CONTAINER_NAME} \
		${CONTAINER_PORT} \
		${DESIRED_TASK_COUNT} \
		${VPC_ID} \
		${TASK_EXEC_ROLE_ARN}

.PHONY: clean

clean:
	rm -rf *.o
