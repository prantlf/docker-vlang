FROM debian:stable-slim
LABEL maintainer="Ferdinand Prantl <prantlf@gmail.com>"

RUN apt-get update -y && apt-get upgrade -y && \
  apt-get install -y --no-install-recommends \
    binutils ca-certificates curl gcc git make patch \
    libc-dev libssl-dev libx11-dev libglfw3-dev libfreetype-dev libsqlite3-dev && \
    apt-get clean && rm -rf /var/cache/apt/archives/* && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/vlang
ARG VTAG
RUN git clone https://github.com/vlang/v /opt/vlang && \
  git checkout ${VTAG} && \
  make && rm -rf .[!.] .??* *.md D* G* L* M* bench changelogs0.x doc \
    examples make.bat tutorials vc && ./v -version
ENV PATH /opt/vlang:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

WORKDIR /src
