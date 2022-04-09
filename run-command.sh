#!/bin/bash
# Commandline tool to send commands and return results from a running factorio server via fifo

# LICENSE NOTICE
# The methodology and some of the code in this file has been copied and adapted from
# the `factorio-init` project located here:
# https://github.com/Bisa/factorio-init/blob/4cafc0d23aa0d0fdbd99a6bf5851908258006372/factorio

# The code in the `factorio-init` project is protected by The MIT License (MIT) 
# The original author is: Tobias Wallin - https://github.com/Bisa

# The MIT license requires that redistributed code retains its original license notice.
# Below is a copy of the original license notice located at:
# https://github.com/Bisa/factorio-init/blob/b476d9e6fd69b3b3a5a59e2968631f065e2fa691/LICENSE
# Code outside of this file is original and not adapted from any other projects.

# This code is used with appreciation and admiration.

<<'###-ORIGINAL-LICENSE-NOTICE-###'
    The MIT License (MIT)

    Copyright (c) 2015 Tobias Wallin - https://github.com/Bisa

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
###-ORIGINAL-LICENSE-NOTICE-###

# Begin script
FIFO_NAME="factorio-server-fifo"
LOG_FILE="factorio-server.log"
COMMAND="$1"

# Generate two unique log markers
TIMESTAMP=$(date +"%s")
START="FACTORIO_INIT_CMD_${TIMESTAMP}_START"
END="FACTORIO_INIT_CMD_${TIMESTAMP}_END"

# Whisper that unknown player to place start marker in log
echo "/w ${START}" > "${FIFO_NAME}"
# Run the actual command
echo "${COMMAND}" > "${FIFO_NAME}"
# Whisper that unknown player again to place end marker in log after the command terminated
echo "/w ${END}" > "${FIFO_NAME}"

# search for the start marker in the log file, then follow and print the log output in real time until the end marker is found
sleep 0.5 
CMD_RESPONSE=$(awk "/Player ${START} doesn't exist./{flag=1;next}/Player ${END} doesn't exist./{exit}flag" < "${LOG_FILE}")
echo ${CMD_RESPONSE}
