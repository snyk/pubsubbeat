FROM golang:1.12 as builder

WORKDIR /code
ADD . . 
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o pubsubbeat .

FROM alpine:3.10

RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /code/pubsubbeat .
CMD ["./pubsubbeat"]
