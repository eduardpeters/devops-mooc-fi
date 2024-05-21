FROM node:16

RUN npm install -g serve

EXPOSE 5000

WORKDIR /usr/src/app

COPY package* .

RUN npm install

COPY . .

RUN npm run build

RUN useradd -m appuser

USER appuser

CMD serve -s -l 5000 build