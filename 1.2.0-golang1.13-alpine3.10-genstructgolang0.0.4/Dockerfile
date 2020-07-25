FROM golang:1.12-alpine3.10 AS BuilderGenStructGraphql

ENV VERSION_GENSTRUCTGRAPHQL=v0.0.4

WORKDIR /go/src/gitlab.com/watud
RUN apk add --update --no-cache git && \
    git clone https://gitlab.com/watud/genstructgraphql.git && \
    cd genstructgraphql/ && \
    git checkout ${VERSION_GENSTRUCTGRAPHQL} && \
    go install

FROM golang:1.11-alpine3.8 AS BuilderCompileDeamon

ENV VERSION_COMPILE_DEAMON=v1.2.0

WORKDIR /go/src/github.com/mvochoa
RUN apk add --update --no-cache git && \
    git clone https://github.com/mvochoa/CompileDaemon.git && \
    cd CompileDaemon/ && \
    git checkout ${VERSION_COMPILE_DEAMON} && \
    go get github.com/fatih/color github.com/fsnotify/fsnotify && \
    go install

FROM golang:1.13-alpine3.10
LABEL maintainer="mario@mvochoa.com"

COPY genstruct.sh /usr/local/bin/genstruct
COPY docker-entrypoint.sh /usr/local/bin/
COPY --from=BuilderCompileDeamon /go/bin/CompileDaemon /usr/local/bin/gomon
COPY --from=BuilderGenStructGraphql /go/bin/genstructgraphql /usr/local/bin/genstructgraphql

RUN apk add --update --no-cache git gcc bind-dev musl-dev
RUN chmod +x /usr/local/bin/gomon && \
    chmod +x /usr/local/bin/genstruct && \
    chmod +x /usr/local/bin/docker-entrypoint.sh && \
    chmod +x /usr/local/bin/genstructgraphql

ENTRYPOINT ["sh", "/usr/local/bin/docker-entrypoint.sh"]