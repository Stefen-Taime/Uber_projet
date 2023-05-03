-- Create the dbt user
CREATE ROLE dbt LOGIN PASSWORD 'dbt_password';

-- Grant the dbt user privileges
ALTER ROLE dbt CREATEDB;

-- Create the OLTP and OLAP databases
CREATE DATABASE oltp WITH OWNER dbt;
CREATE DATABASE olap WITH OWNER dbt;
