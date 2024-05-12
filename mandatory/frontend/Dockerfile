FROM node:16

RUN npm install -g serve

EXPOSE 5000

ARG REACT_APP_BACKEND_URL

ENV REACT_APP_BACKEND_URL ${REACT_APP_BACKEND_URL}

WORKDIR /usr/src/app

COPY package* .

RUN npm install

COPY . .

RUN npm run build

CMD serve -s -l 5000 build