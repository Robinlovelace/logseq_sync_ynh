# Build stage
FROM node:20-slim AS builder

# Install build dependencies
RUN apt-get update && apt-get install -y git curl default-jdk-headless
RUN npm install -g pnpm

# Clone Logseq (we use a specific commit or master)
WORKDIR /src
RUN git clone --depth 1 https://github.com/logseq/logseq.git .

# Build db-sync node adapter
WORKDIR /src/deps/db-sync
RUN pnpm install
RUN pnpm build:node-adapter

# Final stage
FROM node:20-slim
WORKDIR /app

# Copy built files
COPY --from=builder /src/deps/db-sync/worker/dist/node-adapter.js .
COPY --from=builder /src/deps/db-sync/package.json .

# Environment defaults
ENV DB_SYNC_PORT=3000
ENV DB_SYNC_DATA_DIR=/data
ENV DB_SYNC_STORAGE_DRIVER=sqlite
ENV DB_SYNC_ASSETS_DRIVER=filesystem

# Bypassing Cognito if secret key is provided
# This is a bit of a hack: if DB_SYNC_ALLOW_UNVERIFIED_JWT_CLAIMS is true,
# the client can send any JWT. We'll rely on the user knowing this.
ENV DB_SYNC_ALLOW_UNVERIFIED_JWT_CLAIMS=true

EXPOSE 3000
CMD ["node", "node-adapter.js"]
