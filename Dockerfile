FROM golang:alpine
LABEL maintainer "Chen-Han Hsiao (Stanley) <chenhan.hsiao.tw@gmail.com>"

RUN go get -v github.com/caarlos0/starcharts
CMD go run $GOPATH/src/github.com/caarlos0/starcharts/main.go
