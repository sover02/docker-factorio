#!/bin/bash

FIFO_NAME="factorio-server-fifo"
LOG_FILE="factorio-server.log"
FACTORIO_PID_FILE="factorio-server.pid"

echo "Starting Factorio Server..."

# Start the server and track the process ID
rm ${FACTORIO_PID_FILE} > /dev/null 2>&1
./factorio/bin/x64/factorio --start-server $(cat last-game.txt) > ${LOG_FILE} 2>&1 < ${FIFO_NAME} &
echo $! > ${FACTORIO_PID_FILE}

echo "Done!"
