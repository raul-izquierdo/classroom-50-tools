#!/usr/bin/env bash
# Linux/macOS equivalent of update-sies.cmd
# This script guides the user through converting the SIES Excel export and then updates the roster.

set -o pipefail

# Step prompt
echo "Remember to get an updated \"alumnosMatriculados.xls\" from SIES before proceeding."
read -r -p "Press Enter when you are ready to continue..." _

# Run SIES to CSV conversion
echo "Running: java -jar sies2csv.jar"
java -jar sies2csv.jar
rc=$?
if [ "$rc" -ne 0 ]; then
    echo "sies2csv failed with exit code $rc. Stopping."
    exit "$rc"
fi

# CSV file generated from Excel file. Review it before proceeding.
read -r -p "CSV file generated from Excel file. Review it before proceeding with the roster update. Continue? [Y/n] " answer
case "${answer:-Y}" in
  [Nn]|[Nn][Oo])
    echo "User chose not to continue."
    exit 0
    ;;
  *)
    ;;
esac

# Update roster
echo "Running: java -jar roster50.jar"
java -jar roster50.jar
exit $? 

