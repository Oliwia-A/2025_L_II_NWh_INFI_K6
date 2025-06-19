APP_NAME=hello-world-printer
CONTAINER_NAME=hello-world-printer-dev
APP_DIR=/usr/src/hello_world_printer
USERNAME=oliwiaa
TAG=$(USERNAME)/$(APP_NAME)

lint:  ## Run flake8 linter
	flake8 hello_world test

format:  ## Format with black
	black hello_world test

test:  ## Run tests locally
	PYTHONPATH=. pytest -v -s

docker_build:  ## Build Docker image
	docker build -t $(APP_NAME) .

docker_force_build:  ## Force build without cache
	docker rm -f $(CONTAINER_NAME) || true
	docker build --no-cache -t $(APP_NAME) .

docker_run:  ## Run Docker container
	docker run --name $(CONTAINER_NAME) -p 5000:5000 -d $(APP_NAME)

docker_clean:  ## Stop and remove dev container
	docker rm -f $(CONTAINER_NAME) || true

docker_test:  ## Run tests inside container
	docker exec -it $(CONTAINER_NAME) bash -c "cd $(APP_DIR) && export PYTHONPATH=$(APP_DIR) && pytest -v -s"

docker_logs:  ## Show logs from container
	docker logs -f $(CONTAINER_NAME)

docker_push: docker_build  ## Push Docker image to DockerHub
	@docker login --username $(USERNAME) --password $${DOCKER_PASSWORD}; \
	docker tag $(APP_NAME) $(TAG); \
	docker push $(TAG); \
	docker logout

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "🔹 \033[36m%-20s\033[0m %s\n", $$1, $$2}'