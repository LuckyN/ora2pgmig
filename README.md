# OracleToPostgreSQLMigration

This project keeps track of scripts that are used to migrate database schema and data t From YTI Oracle Schemas to Postgresql V5 Schemas
Key Improvements and Explanations:
Log Function:

Added a log function to standardize logging with timestamps, which helps in tracking the progress and issues systematically.
Configuration and Logging:

Introduced a base directory (LOG_DIR) for all logs and data files, organized by schema. This helps in isolating files by their respective schemas and keeps the workspace organized.
Error Handling:

Enhanced error checks after each critical operation (fetching schemas, generating data files, and importing to PostgreSQL) with appropriate logs.
Use of COPY Command:

Modified the ora2pg command to generate COPY statements instead of INSERTS. This is set with -t COPY and the data file is specified along with the output base directory.
PostgreSQL Import Command:

The import command now logs into schema-specific log files. The psql command uses environment variable PGPASSWORD for password input, which is safer in scripts.
Clean Directory Structure:

Each schema gets its own directory under LOG_DIR for better management of SQL files and logs.
Usage Notes:
Ensure that ora2pg configuration (config/ora2pg.conf) is correctly set up for your environment.
Ensure the PostgreSQL client (psql) is installed and accessible from your script's execution environment.
Replace placeholders in the PostgreSQL connection details
# ora2pgmig
