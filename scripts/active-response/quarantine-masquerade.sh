#!/bin/bash
LOG_FILE="/var/ossec/logs/active-responses.log"
INPUT_JSON=$(cat)
echo "$(date) JSON complet recu: $INPUT_JSON" >> $LOG_FILE
