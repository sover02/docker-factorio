#!/bin/bash

# Entrypoint for docker-factorio
# Summary:
# - Creates a fifo to interact with the `factorio` process' stdin for server commands
# - Checks if there's an existing game and creates a new one if not
# - Starts the server, using the fifo for stdin, and `tee`s stdout and stderr to a logfile
# - Uses `interact.sh` to pass keystrokes to the server process, while printing its output
# - Cleans up stale processes before exiting

FIFO_NAME=factorio-server-fifo
LOG_FILE="factorio-server.log"
FACTORIO_PID_FILE="factorio-server.pid"

# Create fifo for interaction with the process and and keep it open
rm ${FIFO_NAME} > /dev/null 2>&1
mkfifo ${FIFO_NAME}

# Check if there's an existing game - create one if not
if [ ! -f "$(cat last-game.txt 2> /dev/null)" ]; then
    SAVE_FILE="factorio-save-$(date +"%Y_%m_%d_%I_%M_%p").zip"
    ./factorio/bin/x64/factorio --create ./saves/${SAVE_FILE} 2>&1 | tee ${LOG_FILE}
    echo "./saves/${SAVE_FILE}" > last-game.txt
fi

# Start the server and track the process ID
rm factorio-server.pid > /dev/null 2>&1
./factorio/bin/x64/factorio --start-server $(cat last-game.txt) > ${LOG_FILE} 2>&1 < ${FIFO_NAME} &
echo $! > ${FACTORIO_PID_FILE}

# Kick off the server and pass keystrokes to the server process' stdin
./interact.sh
kill $(cat ${FACTORIO_PID_FILE})
