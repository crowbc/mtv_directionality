#!/bin/bash

# --- Configuration ---
# Path to your ROOT C script
READ_C_SCRIPT="/usr/WS1/ratpac/tuolumne/ratpac-private/mtv/output/mtv_directionality/readNeutrons.C"

# The final output file
NEUTRONS_FILE="neutrons.txt"

# A temporary file for processing
TEMP_FILE="neutrons.temp.txt"

# --- Script ---

echo "Running ROOT script: $READ_C_SCRIPT"
# Step 1: Run the ROOT script to generate the raw text file
root -l -q "$READ_C_SCRIPT" > "$NEUTRONS_FILE"

echo "Cleaning header and footer..."
# Step 2: Clean the header and footer lines from the raw file
# Remove first 2 lines (e.g., "Processing..." and a blank line)
sed -i '1,2d' "$NEUTRONS_FILE"
# Remove last 2 lines (e.g., ROOT prompt/output)
sed -i '$d; $d' "$NEUTRONS_FILE"

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
' "$NEUTRONS_FILE" > "$TEMP_FILE"

# Step 4: Replace the original file with the new cleaned file
mv "$TEMP_FILE" "$NEUTRONS_FILE"

echo "Cleaning complete. Final output saved to $NEUTRONS_FILE"
echo "Remember to set permissions for group access using chmod 660 $NEUTRONS_FILE"
