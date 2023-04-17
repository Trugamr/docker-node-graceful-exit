FROM node:18.15.0-alpine AS base
RUN corepack enable

FROM base AS development
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm install

FROM base AS production
WORKDIR /app
COPY --from=development /app/node_modules ./node_modules
COPY --from=development /app/package.json /app/pnpm-lock.yaml ./
RUN pnpm prune --prod

FROM base AS build
WORKDIR /app
COPY --from=development /app/node_modules ./node_modules
COPY --from=development /app/package.json /app/pnpm-lock.yaml ./
COPY . .
RUN pnpm run build

FROM base AS release
WORKDIR /app
COPY --from=production /app/node_modules ./node_modules
COPY --from=production /app/package.json /app/pnpm-lock.yaml ./
COPY --from=build /app/dist ./dist
EXPOSE 3000
ENTRYPOINT [ "node", "dist/index.js" ]