# https://github.com/docker-library/golang
FROM golang:1.19 as build-env

WORKDIR /go/src/app

ADD . ./

RUN go build -ldflags="-s -w" -o /go/bin/famed-annotated

# https://github.com/GoogleContainerTools/distroless
FROM gcr.io/distroless/base

COPY --from=build-env /go/bin/famed-annotated /

CMD ["/famed-annotated"]