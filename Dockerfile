FROM golang:latest as builder

LABEL maintainer="John Adebayo <john.bayo@web.de>"

WORKDIR /go/src/github.com/gorilla/
RUN git clone https://github.com/gorilla/mux.git

WORKDIR /go/src/github.com/hashicorp/
RUN git clone https://github.com/hashicorp/logutils.git

WORKDIR /go/src/github.com/endocode/
RUN git clone https://github.com/endocode/hlowrld.git

WORKDIR /go/src/github.com/endocode/hlowrld
RUN go build

#Production image
FROM debian:buster-slim  

WORKDIR /app

COPY --from=builder /go/src/github.com/endocode/hlowrld/hlowrld /app

CMD ["./hlowrld"] 
