#!/bin/bash

# --- Configuration ---
# Path to your ROOT C script
READ_C_SCRIPT="/usr/WS1/ratpac/tuolumne/ratpac-private/mtv/output/mtv_directionality/readPositrons.C"

# The final output file
POSITRONS_FILE="positrons.txt"

# A temporary file for processing
TEMP_FILE="positrons.temp.txt"

# --- Script ---

echo "Running ROOT script: $READ_C_SCRIPT"
# Step 1: Run the ROOT script to generate the raw text file
root -l -q "$READ_C_SCRIPT" > "$POSITRONS_FILE"

echo "Cleaning header and footer..."
# Step 2: Clean the header and footer lines from the raw file
# Remove first 2 lines (e.g., "Processing..." and a blank line)
sed -i '1,2d' "$POSITRONS_FILE"
# Remove last 2 lines (e.g., ROOT prompt/output)
sed -i '$d; $d' "$POSITRONS_FILE"

echo "Removing asterisks..."
# Step 3: Clean the file using awk
# - 'gsub(/\*/,"");' removes all asterisks
# - '{print;}' prints every processed line
awk '
{
    # Remove all asterisks from the current line
    gsub(/\*/,"");
    # Print the cleaned line
    print;
}
' "$POSITRONS_FILE" > "$TEMP_FILE"

# Step 4: Replace the original file with the new cleaned file
mv "$TEMP_FILE" "$POSITRONS_FILE"

echo "Cleaning complete. Final output saved to $POSITRONS_FILE"
echo "Remember to set permissions for the group to access using chmod 660 $POSITRONS_FILE"
