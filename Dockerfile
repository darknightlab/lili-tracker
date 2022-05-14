FROM node:latest

RUN npm install -g bittorrent-tracker

RUN mkdir -p /root/tracker

WORKDIR /root/tracker

ENTRYPOINT ["logsave", "logs.txt", "bittorrent-tracker"]
CMD ["--http", "--ws", "-p", "80", "--trust-proxy", "--interval", "600000"]
