FROM node:22-slim as node
FROM python:3.11-slim

COPY --from=node /usr/local/bin/node /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules /usr/local/lib/node_modules
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && ln -s /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx

WORKDIR /app
RUN pip install mcpo uv

VOLUME ["/root/.cache/uv", "/root/.npm"]
EXPOSE 8000

CMD ["uvx", "mcpo", "--host", "0.0.0.0", "--port", "8000", "--config", "./config.json"]
