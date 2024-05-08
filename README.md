# VLang Docker Image

A Docker image with the [V] language compiler for building within Docker. The GitHub workflow produces an image `ghcr.io/prantlf/vlang:latest` from the latest release of `V`. It is supposed to run at least every week to follow weekly releases of `V`.

## Synopsis

```Dockerfile
FROM ghcr.io/prantlf/vlang as builder

COPY . .
RUN v install && v .

FROM busybox:stable

COPY --from=builder /src/tool /

WORKDIR /
ENTRYPOINT ["/tool"]
```

The default working directory is `/src`. THe `V` compiler is `/opt/vlang/v` and `/opt/vlang` is in `PATH`.

The image `busybox:stable` is a little bigger than `scratch`, but it's convenient, when the image hes to be entered for some investigation. If your program links to other libraries than glibc, you'll ned to add them the target image. Or use the image `debian:stable-slim` as the base image, if the image size isn't critical.

## Contributing

In lieu of a formal styleguide, take care to maintain the existing coding style. Lint and test your code.

## License

Copyright (C) 2024 Ferdinand Prantl

Licensed under the [MIT License].

[MIT License]: http://en.wikipedia.org/wiki/MIT_License
[V]: https://vlang.io
