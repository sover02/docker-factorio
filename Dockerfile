# syntax=docker/dockerfile:1
FROM --platform=linux/amd64 ubuntu:latest
LABEL MAINTAINER='David Anderson "david@misplaced.us"'
RUN apt-get update -y -qq \
    && apt-get install -y -qq wget xz-utils
COPY . /app
WORKDIR /app
RUN wget https://factorio.com/get-download/stable/headless/linux64 -q -O factorio_headless.tar.xz && \
    tar xvf factorio_headless.tar.xz && \
    rm factorio_headless.tar.xz
ENTRYPOINT ["./entrypoint.sh"]
EXPOSE 34197/udp
