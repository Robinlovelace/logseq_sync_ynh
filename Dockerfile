FROM node:20-slim
WORKDIR /app
# We'll use a placeholder for now to prove the plumbing works
# Real app would be built from Logseq deps/db-sync
RUN echo "console.log('Logseq Sync Server placeholder starting...'); \
    const http = require('http'); \
    const server = http.createServer((req, res) => { \
      res.writeHead(200); \
      res.end('Logseq Sync Server (Placeholder)'); \
    }); \
    server.listen(3000);" > index.js
EXPOSE 3000
CMD ["node", "index.js"]
