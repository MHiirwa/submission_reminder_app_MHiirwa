#!/bin/bash

# Prompt user for their name
read -p "Enter your name: " username

# Create main directory
main_dir="submission_reminder_${username}"
mkdir -p "$main_dir"

# Create subdirectories
mkdir -p "$main_dir/app"
mkdir -p "$main_dir/config"
mkdir -p "$main_dir/modules"
mkdir -p "$main_dir/assets"

# Create files with provided content

# config.env
cat > "$main_dir/config/config.env" << 'EOF'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# submissions.txt (with 5 additional records)
cat > "$main_dir/assets/submissions.txt" << 'EOF'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Ahmza, Travel bank, not submitted
Nicia, Newbooking, submitted
Delphine, Trueblue, not submitted
Gina, Snapfinance, submitted
Tracy, Jetblue, not submitted 
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
EOF

# functions.sh
cat > "$main_dir/modules/functions.sh" << 'EOF'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

# reminder.sh
cat > "$main_dir/app/reminder.sh" << 'EOF'
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
EOF


# startup.sh
cat > "$main_dir/startup.sh" << 'EOF'
#!/bin/bash

echo "Starting Submission Reminder App..."
# Use the full path to reminder.sh
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
"$SCRIPT_DIR/app/reminder.sh"
EOF

# Make all .sh files executable
chmod +x "$main_dir/app/reminder.sh"
chmod +x "$main_dir/modules/functions.sh"
chmod +x "$main_dir/startup.sh"

echo "Environment setup complete in $main_dir"
