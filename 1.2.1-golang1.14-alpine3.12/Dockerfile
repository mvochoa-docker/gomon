FROM golang:1.11.1 AS builder

ENV VERSION_COMPILE_DEAMON=v1.2.1
ENV GO111MODULE=off

WORKDIR /go/src/github.com/githubnemo
RUN git clone https://github.com/githubnemo/CompileDaemon.git && \
    cd CompileDaemon/ && \
    git branch build ${VERSION_COMPILE_DEAMON} && \
    git checkout build && \
    go get github.com/fatih/color github.com/fsnotify/fsnotify && \
    go install

FROM golang:1.14-alpine3.12
LABEL maintainer="mario@mvochoa.com"

COPY --from=builder /go/bin/CompileDaemon /usr/local/bin/gomon

RUN apk add --update --no-cache git

RUN chmod +x /usr/local/bin/gomon