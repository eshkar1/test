{{ config(materialized='view') }}


with account as (
select
*
from SFDC_PROD_DB.SFDC_MAIN_SCH.account
)

select * from account