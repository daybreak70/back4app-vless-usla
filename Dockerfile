FROM node:20-bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates curl unzip python3 openssl procps psmisc \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY index.js start.sh package.json ./
ENV FILE_PATH=/app/.tmp
RUN mkdir -p .tmp \
 && curl -fsSL -o /tmp/x.zip https://github.com/XTLS/Xray-core/releases/download/v25.1.30/Xray-linux-64.zip \
 && unzip -o /tmp/x.zip xray -d .tmp && mv .tmp/xray .tmp/web && rm /tmp/x.zip \
 && curl -fsSL -o .tmp/bot https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 \
 && chmod +x .tmp/web .tmp/bot start.sh
CMD ["bash", "/app/start.sh"]
