#!/usr/bin/env bash

OUTPUT_FILE="$HOME/Logs/datelog.log"
if [ ! -d "$(dirname "$OUTPUT_FILE")" ]; then
    mkdir -p "$(dirname "$OUTPUT_FILE")"
fi

function log_usage() {
    echo "$(date +%s) $(date +%T) $(date +%d/%m/%Y) $(date +%H:%M:%S) $(date +%s)" >> $OUTPUT_FILE
}

log_usage
