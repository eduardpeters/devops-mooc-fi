FROM golang:1.16-alpine AS build-stage

WORKDIR /usr/src/app

COPY go.mod go.sum ./

RUN go mod download && go mod verify

COPY . .

RUN CGO_ENABLED=0 go build && adduser --disabled-password --no-create-home appuser

FROM scratch

COPY --from=build-stage /etc/passwd /etc/passwd

COPY --from=build-stage /usr/src/app/server .

EXPOSE 8080

USER appuser

CMD ["./server"]