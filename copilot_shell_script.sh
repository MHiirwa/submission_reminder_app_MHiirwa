#!/bin/bash

# Find the submission reminder directory
main_dir=$(find . -type d -name "submission_reminder_*" | head -n 1)

[ -z "$main_dir" ] && { echo "Error: Could not find submission_reminder directory"; exit 1; }

# Update config file and restart
config_file="$main_dir/config/config.env"
[ ! -f "$config_file" ] && { echo "Error: config.env not found"; exit 1; }

while true; do
    read -p "Enter the new assignment name: " assignment_name
    [ -n "$assignment_name" ] && break
    echo "Error: Assignment name cannot be empty"
done

# Update and restart
if sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$(sed 's/[\/&]/\\&/g' <<< "$assignment_name")\"/" "$config_file"; then
    echo "Assignment updated to: $assignment_name"
    echo "Restarting application..."
    cd "$main_dir" && ./startup.sh
else
    echo "Error: Failed to update config"
    exit 1
fi
