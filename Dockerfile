##
## Build
##
FROM golang:1.18 AS build

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
FROM perconalab/percona-toolkit:3.2.1

WORKDIR /
COPY --from=build /app/build/db-savior /db-savior
CMD ["/db-savior"]
