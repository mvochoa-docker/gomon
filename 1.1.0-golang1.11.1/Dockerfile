FROM golang:1.11.1 AS builder

ENV VERSION_COMPILE_DEAMON=v.1.1.0

WORKDIR /go/src/github.com/githubnemo
RUN git clone https://github.com/githubnemo/CompileDaemon.git && \
    cd CompileDaemon/ && \
    git checkout ${VERSION_COMPILE_DEAMON} && \
    go get github.com/fatih/color github.com/fsnotify/fsnotify && \
    go install

FROM golang:1.11.1

COPY --from=builder /go/bin/CompileDaemon /usr/local/bin/gomon

RUN chmod +x /usr/local/bin/gomon