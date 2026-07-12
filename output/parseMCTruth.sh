#!/bin/bash

# --- Configuration ---
# Path to your ROOT C script
READ_C_SCRIPT="/usr/WS1/ratpac/tuolumne/ratpac-private/mtv/output/mtv_directionality/readMCTruth.C"

# The final output file
TRUTH_FILE="truth.txt"

# A temporary file for processing
TEMP_FILE="truth.temp.txt"

# --- Script ---

echo "Running ROOT script: $READ_C_SCRIPT"
# Step 1: Run the ROOT script to generate the raw text file
root -l -q "$READ_C_SCRIPT" > "$TRUTH_FILE"

echo "Cleaning header and footer..."
# Step 2: Clean the header and footer lines from the raw file
# Remove first 2 lines (e.g., "Processing..." and a blank line)
sed -i '1,2d' "$TRUTH_FILE"
# Remove last 2 lines (e.g., ROOT prompt/output)
sed -i '$d; $d' "$TRUTH_FILE"

echo "Filtering for unique 'Row' entries and removing asterisks..."
# Step 3: Filter the file using awk
# - 'gsub(/\*/,"");' removes all asterisks (replaces sed 's/\*//g')
# - 'NR==1 {print; next;}' prints the first line (the header) and skips to the next line
# - '!seen[$1]++ {print;}' checks column 1 ($1). If this "Row" value hasn't
#   been 'seen' before, it prints the line and marks it as seen.
awk '
{
    # Remove all asterisks from the current line
    gsub(/\*/,"");
}
NR==1 {
    # This is the header line
    print;
    next; # Go to the next line
}
!seen[$1]++ {
    # If this is the first time we see the value in column 1 ($1),
    # print the line. The !seen[$1]++ idiom handles this.
    print;
}
' "$TRUTH_FILE" > "$TEMP_FILE"

# Step 4: Replace the original file with the new filtered file
mv "$TEMP_FILE" "$TRUTH_FILE"

echo "Filtering complete. Final output saved to $TRUTH_FILE"
echo "Remember to set permissions for the group using chmod 660 $TRUTH_FILE"
