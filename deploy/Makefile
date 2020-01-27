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

prepare-n-push-image:
	echo "Build, tag and push images to your registry"
	./scripts/prepare-n-push-image.sh

register-task-definition:
	echo "Register (t)ask definition"
	./scripts/register-task-definition.sh ${t}

create-service:
	echo "Create ecs web service by feeding (c)onfigs in a json file"
	./scripts/create-service.sh ${c}

deregister-task-definition:
	echo "Deregister a task definition by (t)ask and (r)evision"
	./scripts/deregister-task-definition.sh ${t} $(r)

update-service:
	echo "Update a running ecs web service with (t)task definition, (c)service config, desired count(cnt)"
	./scripts/update-service.sh ${t} ${c} ${cnt}

.PHONY: clean

clean:
	rm -rf *.o
