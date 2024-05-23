FROM node:16-alpine as build-stage

WORKDIR /usr/src/app

COPY package* .

RUN npm install

COPY . .

RUN npm run build

FROM node:16-alpine

WORKDIR /usr/src/app

COPY --from=build-stage /usr/src/app/build .

RUN npm install -g serve && adduser -D appuser

EXPOSE 5000

USER appuser

CMD serve -s -l 5000