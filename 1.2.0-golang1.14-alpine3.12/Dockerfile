FROM golang:1.11.1 AS builder
ENV VERSION_COMPILE_DEAMON=v1.2.0

WORKDIR /go/src/github.com/mvochoa
RUN git clone https://github.com/mvochoa/CompileDaemon.git && \
    cd CompileDaemon/ && \
    git checkout ${VERSION_COMPILE_DEAMON} && \
    go get github.com/fatih/color github.com/fsnotify/fsnotify && \
    go install

FROM golang:1.14-alpine3.12
LABEL maintainer="mario@mvochoa.com"

COPY --from=builder /go/bin/CompileDaemon /usr/local/bin/gomon

RUN apk add --update --no-cache git

RUN chmod +x /usr/local/bin/gomon