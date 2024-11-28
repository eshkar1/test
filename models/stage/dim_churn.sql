-- {{ config(materialized='table') }}

with ACCOUNT as (
    select * from {{ ref('account_tbl')}}
),

OPP_TBL as (
    select * from {{ ref('opp_tbl')}}
)

select
*
from account a
left join OPP_TBL o on  a.account_master_id__c = o.account_master_id__c
where
YEAR (TO_DATE (churn_date__c)) = 2024
and 
(
(a.name not like '%Mcdonalds%' and  o.type in ('Renewal', 'Renewal/Upsell'))

or (o.type = 'Terminated' and o.stagename = 'Closed Won')

and change_in_arr_in_usd__c < 0 )
