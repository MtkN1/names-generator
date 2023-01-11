#build stage
FROM golang:1.19-alpine AS builder
RUN apk add --no-cache git
WORKDIR /go/src/app
COPY . .
RUN go get -d -v ./...
RUN go build -o /go/bin/app -v ./...

#final stage
FROM alpine:latest
COPY --from=builder /go/bin/app /app
ENTRYPOINT /app
