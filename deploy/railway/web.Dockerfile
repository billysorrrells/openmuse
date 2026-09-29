# OpenMuse web client (Expo web export) served as static files
FROM node:24-bookworm-slim AS build
WORKDIR /app
RUN corepack enable
ARG EXPO_PUBLIC_API_URL
ENV EXPO_PUBLIC_API_URL=$EXPO_PUBLIC_API_URL
COPY . .
RUN pnpm install --frozen-lockfile && pnpm build:web

FROM node:24-bookworm-slim
WORKDIR /app
RUN npm i -g serve@14
COPY --from=build /app/apps/mobile/dist/web ./web
ENV PORT=8080
CMD ["sh", "-c", "serve -s web -l tcp://0.0.0.0:${PORT}"]
