FROM node:16-alpine

EXPOSE 5000

# Passing env variable no longer needed with reverse proxy
#ARG REACT_APP_BACKEND_URL
#ENV REACT_APP_BACKEND_URL ${REACT_APP_BACKEND_URL}

WORKDIR /usr/src/app

COPY package* .

RUN npm install -g serve && npm install

COPY . .

RUN npm run build && adduser -D appuser

USER appuser

CMD serve -s -l 5000 build