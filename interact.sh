#!/bin/bash
cat > factorio-server-fifo <&0 2> /dev/null &
tail -f factorio-server.log