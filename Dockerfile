FROM debian:stable-slim AS base-386

FROM debian:stable-slim AS base-amd64

# FROM balenalib/rpi-debian:latest AS base-armv6

# FROM debian:stable-slim AS base-armv7

FROM debian:stable-slim AS base-arm64

FROM riscv64/debian:unstable-slim AS base-riscv64

FROM base-$TARGETARCH$TARGETVARIANT
LABEL maintainer="Ferdinand Prantl <prantlf@gmail.com>"

RUN apt-get update -y && apt-get upgrade -y && \
  apt-get install -y --no-install-recommends \
    binutils ca-certificates curl gcc git make patch \
    libc-dev libssl-dev libx11-dev libglfw3-dev libfreetype-dev libsqlite3-dev && \
    apt-get clean && rm -rf /var/cache/apt/archives/* && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/vlang
ARG VTAG
RUN git clone https://github.com/vlang/v /opt/vlang && \
  git checkout "${VTAG}" && \
  CC=gcc VFLAGS="-cc gcc -d use_bundled_libgc" make && \
  rm -rf .[!.] .??* *.md D* G* L* M* bench changelogs0.x doc \
    examples make.bat tutorials vc && ./v -version
ENV PATH /opt/vlang:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

WORKDIR /src
