# OpenMuse API server for Railway (BSE deployment)
FROM node:24-bookworm-slim AS build
WORKDIR /app
RUN corepack enable
COPY . .
RUN pnpm install --frozen-lockfile && pnpm build:server && pnpm prune --prod

FROM node:24-bookworm-slim
WORKDIR /app
ENV NODE_ENV=production HOST=0.0.0.0 DATA_DIR=/data
COPY --from=build /app /app
RUN mkdir -p /data
EXPOSE 8787
CMD ["node", "dist/apps/server/src/index.js"]
