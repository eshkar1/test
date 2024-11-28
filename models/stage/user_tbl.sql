{{ config(materialized='view') }}


with user as (
select
*
from SFDC_PROD_DB.SFDC_MAIN_SCH.user
)

select * from user