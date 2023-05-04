# PostgreSQL Database Object DDL Generator

This script generates DDL for each PostgreSQL database object in a separate file. The script is written in Bash and is parameterized with hardcoded values. Before running the script, you need to update the server details as per your requirements.

## Usage

1. Update the server details in the script.

2. Run the script.

## Configuration

The following configuration variables are used in the script and need to be updated before running the script.

- `PGPASSWORD`: the password for the PostgreSQL database.
- `db`: the name of the database.
- `user`: the username for the PostgreSQL database.
- `server`: the IP address of the PostgreSQL server.
- `port`: the port number of the PostgreSQL server.
- `DIR`: the directory where the dump files will be saved.

## Functionality

The script backs up the following PostgreSQL database objects:

1. **BASE TABLES:** The script backs up all base tables that meet the following criteria:
   - table_type = 'BASE TABLE'
   - table_name not ending with 8 digits
   - table_name not ending with 6 digits
   - table_name not containing '_old'
   - table_name not containing '_backup'
   - table_name not containing '_test'

2. **FOREIGN TABLES:** The script backs up all foreign tables that meet the following criteria:
   - table_type = 'FOREIGN'
   - table_name not ending with 8 digits
   - table_name not ending with 6 digits
   - table_name not containing '_old'
   - table_name not containing '_backup'
   - table_name not containing '_test'

3. **VIEWS:** The script backs up all views in the public schema.

4. **FUNCTIONS:** The script backs up all functions in the public schema that meet the following criteria:
   - language is not 'c' or 'internal'
   - schema is not 'pg_%' or 'information_schema'

The generated dump files are saved in the directory specified by the `DIR` variable. The dump files are saved in the following directories within the specified directory:
- `$DIR/public/tables`
- `$DIR/public/foreign_tables`
- `$DIR/public/views`
- `$DIR/public/functions`

## Author

The script was written by Alwyn D'Souza.