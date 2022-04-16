FROM node:16-alpine as builder

USER root

RUN mkdir -p /usr/app

WORKDIR '/usr/app'

COPY --chown=node:node package.json ./

RUN npm install

COPY --chown=node:node ./ ./

RUN npm run build

FROM nginx

EXPOSE 80

COPY --from=builder /usr/app/build /usr/share/nginx/html



