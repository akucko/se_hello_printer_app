.PHONY: test

USERNAME=akucko
TAG=$(USERNAME)/hello_world_printer

deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt
lint:
	flake8 hello_world test
run:
	python main.py
test:
	PYTHONPATH=. py.test  --verbose -s
test_smoke:
	curl -I --fail 127.0.0.1:5000
docker_build:
	docker build -t hello_world_printer .
docker_run: docker_build
	docker run \
	--name hello_world_printer-dev \
	-p 5000:5000 \
	-d hello_world_printer
docker_push: docker_build
	@docker login --username $(USERNAME) --password $${DOCKER_PASSWORD}; \
	docker tag hello_world_printer $(TAG); \
	docker push $(TAG); \
	docker logout;
