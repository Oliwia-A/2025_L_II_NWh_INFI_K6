APP_NAME=hello-world-printer
CONTAINER_NAME=hello-world-printer-dev
APP_DIR=/usr/src/hello_world_printer

lint:  ## Run flake8 linter on source and tests
	flake8 hello_world test

format:  ## Auto-format code with Black
	black hello_world test

test:  ## Run all tests locally with pytest
	PYTHONPATH=. pytest -v -s

docker_build:  ## Build Docker image from Dockerfile
	docker build -t $(APP_NAME) .

docker_force_build:  ## Force rebuild image with no cache
	docker rm -f $(CONTAINER_NAME) || true
	docker build --no-cache -t $(APP_NAME) .

docker_run:  ## Run container and expose port 5000
	docker run --name $(CONTAINER_NAME) -p 5000:5000 -d $(APP_NAME)

docker_clean:  ## Kill and remove running dev container
	docker rm -f $(CONTAINER_NAME) || true

docker_test:  ## Run tests inside Docker container
	docker exec -it $(CONTAINER_NAME) bash -c "cd $(APP_DIR) && export PYTHONPATH=$(APP_DIR) && pytest -v -s"

docker_logs:  ## Tail logs from running container
	docker logs -f $(CONTAINER_NAME)

docker_push:  ## Push Docker image to DockerHub
	docker tag $(APP_NAME) YOUR_DOCKERHUB_USERNAME/$(APP_NAME)
	docker push YOUR_DOCKERHUB_USERNAME/$(APP_NAME)

deps:  ## Install app and test dependencies
	pip install -r requirements.txt
	pip install -r test_requirements.txt


help:  ## Show list of available make commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "🔹 \033[36m%-20s\033[0m %s\n", $$1, $$2}'