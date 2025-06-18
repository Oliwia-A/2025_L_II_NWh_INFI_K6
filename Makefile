APP_NAME=hello-world-printer
CONTAINER_NAME=hello-world-printer-dev
APP_DIR=/usr/src/hello_world_printer

lint:
	flake8 hello_world test

format:
	black hello_world test

test:
	PYTHONPATH=. pytest -v -s

docker_build:
	docker build -t $(APP_NAME) .

docker_force_build:
	docker rm -f $(CONTAINER_NAME) || true
	docker build --no-cache -t $(APP_NAME) .

docker_run:
	docker run --name $(CONTAINER_NAME) -p 5000:5000 -d $(APP_NAME)

docker_clean:
	docker rm -f $(CONTAINER_NAME) || true

docker_test:
	docker exec -it $(CONTAINER_NAME) bash -c "cd $(APP_DIR) && export PYTHONPATH=$(APP_DIR) && pytest -v -s"

docker_logs:
	docker logs -f $(CONTAINER_NAME)

docker_push:
	docker tag $(APP_NAME) YOUR_DOCKERHUB_USERNAME/$(APP_NAME)
	docker push YOUR_DOCKERHUB_USERNAME/$(APP_NAME)