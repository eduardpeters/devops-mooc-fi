FROM golang:1.16

EXPOSE 8080

WORKDIR /usr/src/app

COPY go.mod go.sum ./

RUN go mod download && go mod verify

COPY . .

RUN go build

RUN adduser --disabled-password --no-create-home appuser

USER appuser

CMD ./server