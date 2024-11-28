{{ config(materialized='view') }}


with OPP_TBL as (
select
*
from SFDC_PROD_DB.SFDC_MAIN_SCH.OPP_TBL
)

select * from OPP_TBL