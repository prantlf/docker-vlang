all:: lint build

lint::
	docker run --rm -i \
		-v ${PWD}/.hadolint.yaml:/bin/hadolint.yaml \
		-e XDG_CONFIG_HOME=/bin hadolint/hadolint \
		< Dockerfile

lint-others::
	docker run --rm -i \
		-v ${PWD}/.hadolint.yaml:/bin/hadolint.yaml \
		-e XDG_CONFIG_HOME=/bin hadolint/hadolint \
		< Dockerfile.alpine
	docker run --rm -i \
		-v ${PWD}/.hadolint.yaml:/bin/hadolint.yaml \
		-e XDG_CONFIG_HOME=/bin hadolint/hadolint \
		< Dockerfile.alpine-unpack
	docker run --rm -i \
		-v ${PWD}/.hadolint.yaml:/bin/hadolint.yaml \
		-e XDG_CONFIG_HOME=/bin hadolint/hadolint \
		< Dockerfile.unpack

build::
	docker build -t vlang .

build-unpack::
	docker build -t vlang -f Dockerfile.unpack .

build-alpine::
	docker build -t vlang -f Dockerfile.alpine .

build-alpine-unpack::
	docker build -t vlang -f Dockerfile.alpine-rebuild .

enter::
	docker run --rm -it --entrypoint sh vlang
