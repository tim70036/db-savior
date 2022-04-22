##
## Build
##
FROM golang:1.18 AS build

WORKDIR /src

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . ./
RUN ls -al
RUN go mod download
RUN go build -o ./build/db-savior
