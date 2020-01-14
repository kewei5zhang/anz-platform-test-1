FROM golang:alpine AS builder
ENV GO111MODULE=on
WORKDIR /app
ADD ./ /app
RUN apk update --no-cache && apk add git
RUN CGO_ENABLED=0 GOOS=linux go build -o golang-test  .

# final stage
FROM scratch
COPY --from=builder /app/golang-test /app/
EXPOSE 8000
ENTRYPOINT ["/app/golang-test"]