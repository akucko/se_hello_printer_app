.PHONY: test
deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt
lint:
	flake8 hello_world test
run:
	python main.py
test:
	PYTHONPATH=. py.test  --verbose -s
docker_build:
	docker build -t hello_world_printer .
docker_run: docker_build
	docker run \
	--name hello_world_printer-dev \
	-p 5000:5000 \
	-d hello_world_printer
