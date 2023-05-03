##
## Build
##
FROM golang:1.20-alpine3.17 AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . ./
RUN go mod download
RUN go build -o ./build/db-savior

##
## Deploy
##
FROM alpine:3.17
WORKDIR /

ENV PERCONA_TOOLKIT_VERSION 3.3.1
RUN set -x \
  && apk add --update perl perl-dbi perl-dbd-mysql perl-io-socket-ssl perl-term-readkey make ca-certificates wget \
  && update-ca-certificates \
  && wget -O /tmp/percona-toolkit.tar.gz https://www.percona.com/downloads/percona-toolkit/${PERCONA_TOOLKIT_VERSION}/source/tarball/percona-toolkit-${PERCONA_TOOLKIT_VERSION}.tar.gz \
  && tar -xzvf /tmp/percona-toolkit.tar.gz -C /tmp \
  && cd /tmp/percona-toolkit-${PERCONA_TOOLKIT_VERSION} \
  && perl Makefile.PL \
  && make \
  && make test \
  && make install \
  && apk del make ca-certificates wget \ 
  && rm -rf /var/cache/apk/* /tmp/percona-toolkit*

COPY --from=build /app/build/db-savior /db-savior
RUN ls -al
ENTRYPOINT ["/db-savior"]
