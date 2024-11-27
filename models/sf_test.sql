{{ config(materialized='view') }}

use role snowflake_accountadmin_role
;
use warehouse transforming
;


select *
from db_salesforce.schema_salesforce.salesforce_account
