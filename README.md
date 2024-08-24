# VLang Docker Image

A Docker image with the [V] language compiler for building within Docker and packages with V for various architectures inlcuding RISC-V.

The GitHub workflow produces images `ghcr.io/prantlf/vlang` and `prantlf/vlang` (on hub.docker.com) from the latest release of `V` for the following platforms: `linux-x86`, `linux-x64`, `linux-arm64`, `linux-riscv64`. They are compiled with `gcc` and with the bundled `libgc` library.

It is scheduled to run at least every week to follow weekly releases of `V`. The image will be tagged by the `V` release name, `latest` and the image produced the last time will be tagged by `previous`. For example, how to access the image by name and the latest one:

    ghcr.io/prantlf/vlang:weekly.2024.34
    ghcr.io/prantlf/vlang:latest

    prantlf/vlang:weekly.2024.34
    prantlf/vlang:latest

Additionally, archives with the V compiler for the same platforms are available for download from [GitHub Releases].

## Synopsis

```Dockerfile
FROM prantlf/vlang as builder

COPY . .
RUN v install && v .

FROM busybox:stable

COPY --from=builder /src/tool /

WORKDIR /
ENTRYPOINT ["/tool"]
```

The default working directory is `/src`. The V compiler is `/opt/vlang/v` and `/opt/vlang` is in `PATH`.

The image `busybox:stable` is a little bigger than `scratch`, but it's convenient, when the image hes to be entered for some investigation. If your program links to other libraries than glibc, you'll ned to add them the target image. Or use a Debian image as the base image, if the image size isn't critical:

| Image                          | Architectures         |
|:-------------------------------|:----------------------|
| `debian:stable-slim`           | `x86`, `x64`, `arm64` |
| `riscv64/debian:unstable-slim` | `riscv64`             |

## Contributing

In lieu of a formal styleguide, take care to maintain the existing coding style. Lint and test your code.

## License

Copyright (C) 2024 Ferdinand Prantl

Licensed under the [MIT License].

[MIT License]: http://en.wikipedia.org/wiki/MIT_License
[V]: https://vlang.io
[GitHub Releases]: https://github.com/prantlf/docker-vlang/releases
