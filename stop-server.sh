#!/bin/bash

LOG_FILE="factorio-server.log"
FACTORIO_PID_FILE="factorio-server.pid"

echo "Stopping Factorio Server..." | tee ${LOG_FILE}

kill $(cat ${FACTORIO_PID_FILE}) > /dev/null 2>&1
rm ${FACTORIO_PID_FILE} > /dev/null 2>&1
sleep 4

echo "Done!"
