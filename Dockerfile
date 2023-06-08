FROM node:lts-alpine as builder

WORKDIR /app

RUN npm install -g pkg node-pre-gyp && \
    apk add --no-cache git && \
    git clone https://github.com/darknightlab/bittorrent-tracker.git && \
    cd bittorrent-tracker && \
    # 等待pkg支持es moule, 再更新到新版
    git checkout cjs && \
    npm install && \
    pkg -t host -o build/bittorrent-tracker .

FROM alpine:latest

COPY --from=builder /app/bittorrent-tracker/build/bittorrent-tracker /usr/bin/bittorrent-tracker

ENTRYPOINT ["/usr/bin/bittorrent-tracker"]
CMD ["--http", "--ws", "-p", "80", "--trust-proxy", "--interval", "600000"]
