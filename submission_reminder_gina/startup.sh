#!/bin/bash

echo "Starting Submission Reminder App..."
# Use the full path to reminder.sh
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
"$SCRIPT_DIR/app/reminder.sh"
