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

build-alpine-amd64::
	docker buildx build --progress plain --platform linux/amd64 -t vlang-alpine-amd64 --build-arg VTAG=weekly.2024.34 -f Dockerfile.alpine .

build-alpine-386::
	docker buildx build --progress plain --platform linux/386 -t vlang-alpine-386 --build-arg VTAG=weekly.2024.34 -f Dockerfile.alpine .

build-amd64::
	docker buildx build --progress plain --platform linux/amd64 -t vlang-amd64 --build-arg VTAG=weekly.2024.34 .

create-amd64::
	docker run --name=build-amd64 -it --platform=linux/amd64 debian:stable-slim

enter-amd64::
	docker exec -it build-amd64 bash

build-386::
	docker buildx build --progress plain --platform linux/386 -t vlang-386 --build-arg VTAG=weekly.2024.34 .

create-386::
	docker run --name=build-386 -it --platform=linux/386 debian:stable-slim

enter-386::
	docker exec -it build-386 bash

build-armv6::
	docker buildx build --progress plain --platform linux/arm/v6 -t vlang-armv6 --build-arg VTAG=weekly.2024.34 .

build-armv7::
	docker buildx build --progress plain --platform linux/arm/v7 -t vlang-armv7 --build-arg VTAG=weekly.2024.34 .

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
