#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

# Source environment variables and helper functions using absolute paths
source "$SCRIPT_DIR/../config/config.env"
source "$SCRIPT_DIR/../modules/functions.sh"

# Path to the submissions file
submissions_file="$SCRIPT_DIR/../assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "$submissions_file"
