#!/bin/bash
FIFO_NAME=factorio-server-fifo
LOG_FILE="factorio-server.log"

# Create fifo for interaction with the process and and keep it open
rm ${FIFO_NAME} > /dev/null 2>&1
mkfifo ${FIFO_NAME}

# Check if there's an existing game - create one if not
if [ ! -f "$(cat last-game.txt 2> /dev/null)" ]; then
    SAVE_FILE="factorio-save-$(date +"%Y_%m_%d_%I_%M_%p").zip"
    ./factorio/bin/x64/factorio --create ./saves/${SAVE_FILE} 2>&1 | tee ${LOG_FILE}
    echo "./saves/${SAVE_FILE}" > last-game.txt
fi

rm factorio-server.pid > /dev/null 2>&1
./factorio/bin/x64/factorio --start-server $(cat last-game.txt) > ${LOG_FILE} 2>&1 < ${FIFO_NAME} &
echo $! > factorio-server.pid

# Kick off the server
./interact.sh
