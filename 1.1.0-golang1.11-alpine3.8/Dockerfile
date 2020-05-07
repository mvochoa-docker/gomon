FROM golang:1.11-alpine3.8 AS builder

ENV VERSION_COMPILE_DEAMON=v.1.1.0

WORKDIR /go/src/github.com/githubnemo
RUN apk add --update --no-cache git && \
    git clone https://github.com/githubnemo/CompileDaemon.git && \
    cd CompileDaemon/ && \
    git checkout ${VERSION_COMPILE_DEAMON} && \
    go get github.com/fatih/color github.com/fsnotify/fsnotify && \
    go install

FROM golang:1.11-alpine3.8

COPY docker-entrypoint.sh /usr/local/bin/
COPY --from=builder /go/bin/CompileDaemon /usr/local/bin/gomon

RUN apk add --update --no-cache git gcc bind-dev musl-dev
RUN chmod +x /usr/local/bin/gomon && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["sh", "/usr/local/bin/docker-entrypoint.sh"]