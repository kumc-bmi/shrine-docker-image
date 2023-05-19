.PHONY: build lint

build:
	docker build --tag shrine:$(TAG) .

lint:
	find -name *.sh | xargs shellcheck &&\
	find -name *.yml | xargs yamllint &&\
	find -name *.py | xargs flake8
