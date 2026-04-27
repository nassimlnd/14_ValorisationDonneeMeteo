FROM dhi.io/node:24-debian13-dev AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

FROM dhi.io/node:24

WORKDIR /app

COPY --from=build /app/.output /app/.output

ENV NODE_ENV=production

EXPOSE 3000
CMD ["node", ".output/server/index.mjs"]
