# syntax=docker/dockerfile:1
FROM --platform=linux/amd64 ubuntu:latest
RUN apt-get update -y -qq \
    && apt-get install -y -qq wget xz-utils
WORKDIR /app
RUN wget https://factorio.com/get-download/stable/headless/linux64 -q -O factorio_headless.tar.xz && \
    tar xvf factorio_headless.tar.xz && \
    rm factorio_headless.tar.xz
WORKDIR /app/factorio
RUN bin/x64/factorio --create ./saves/my-save.zip
CMD ["bin/x64/factorio", "--start-server", "./saves/my-save.zip"]
EXPOSE 34197/udp
