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

export TARGET_GROUP_ARN=arn:aws:elasticloadbalancing:ap-southeast-2:216659404274:targetgroup/dockerzon-lb-tg/93ef0d937de5ccbe
export CONTAINER_NAME=nginx
export CONTAINER_PORT=80
export SERVICE_ROLE_ARN=arn:aws:iam::216659404274:role/ecs-deepdive-servicerole
export DESIRED_TASK_COUNT=2

prepare-n-push-image:
	echo "Build, tag and push images to your registry"
	./scripts/prepare-n-push-image.sh

create-service:
	echo "Create ecs web service by feeding (c)onfigs in a json file"
	./scripts/create-service.sh

update-service:
	echo "Update a running ecs web service with (t)task definition, (c)service config, desired count(cnt)"
	./scripts/update-service.sh ${t} ${c} ${cnt}

.PHONY: clean

clean:
	rm -rf *.o
