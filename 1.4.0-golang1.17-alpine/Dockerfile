FROM golang:1.17 AS builder

ENV GO111MODULE=on
ENV VERSION_COMPILE_DEAMON=v1.4.0

RUN git clone https://github.com/githubnemo/CompileDaemon.git \
    && cd CompileDaemon/ \
    && git checkout tags/${VERSION_COMPILE_DEAMON} \
    && go install

FROM golang:1.17-alpine
LABEL maintainer="mario@mvochoa.com"

COPY --from=builder /go/bin/CompileDaemon /usr/local/bin/gomon

RUN apk add --update --no-cache git

RUN chmod +x /usr/local/bin/gomon
