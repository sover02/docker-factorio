#!/bin/bash

# Simple interaction script for factorio's server process
# Summary:
# - Redirects keystrokes to the fifo that the factorio server is listening to in real time
# - Prints the server process output in real time
# - Cleans up stale processes before exiting

FIFO_NAME=factorio-server-fifo
LOG_FILE="factorio-server.log"

cat > ${FIFO_NAME} <&0 2> /dev/null &
stdin_cat_pid=$!

tail -f ${LOG_FILE}
kill ${stdin_cat_pid} > /dev/null 2>&1
