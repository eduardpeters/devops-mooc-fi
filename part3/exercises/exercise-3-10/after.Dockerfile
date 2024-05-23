FROM node:20-alpine as build-stage

WORKDIR /app

COPY package* .

RUN npm ci

COPY . .

RUN npm run build

FROM node:20-alpine

WORKDIR /app

COPY --from=build-stage /app/dist /app/dist

RUN adduser -D appuser

EXPOSE 4242

USER appuser

CMD [ "npm", "run", "serve" ]