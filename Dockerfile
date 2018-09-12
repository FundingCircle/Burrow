FROM golang:1.11-alpine as builder

ENV CGO_ENABLED=0
COPY . $GOPATH/src/github.com/linkedin/Burrow/
RUN cd $GOPATH/src/github.com/linkedin/Burrow && \
      go build -o /tmp/burrow .

FROM alpine
MAINTAINER LinkedIn Burrow "https://github.com/linkedin/Burrow"

WORKDIR /app
COPY --from=builder /tmp/burrow /app/
ADD /burrow.toml /etc/burrow/

EXPOSE 8080
CMD ["/app/burrow", "--config-dir", "/etc/burrow"]
