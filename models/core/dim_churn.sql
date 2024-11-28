-- {{ config(materialized='table') }}

-- create or replace dim

with ACCOUNT as (
    select * from {{ ref('account_tbl')}}
),

OPP_TBL as (
    select * from {{ ref('opp_tbl')}}
),

user as (
    select * from {{ ref('user_tbl')}}
)


select
churn_date__c,
u.name as csm_owner,
a.name as account_name,
o.name as opportunity_name,
o.type as type,
stagename,
o.closedate as close_date,
a.total_arr__c as total_arr,
CHANGE_IN_ARR_IN_USD__C as change_in_arr_in_usd,
previous_arr_in_usd__c as previous_arr_in_usd,
loss_reason__c as loss_reason,
a.churn_reason__c as primary_churn_reason,
closed_lost_details__c as closed_lost_details,
a.account_status__c,
a.CUSTOMER_JOURNEY_STAGE__C,
a.CSM_SENTIMENT__C,
a.sentiment_notes__c,
a.renewal_date__c as renewal_date,
o.id as opp_id,
license_start_date__c as license_start_date,
license_end_date__c as license_end_date,
a.secondary_churn_reason__c as secondary_churn_reason,
forcast__c as forecast,
o.account_master_id__c,
new_arr_in_usd__c as new_arr_in_usd, 
a.total_arr_in_usd__c as total_arr_in_usd,
-- at.Product_Issues__c as product_issues
from account a
left join OPP_TBL o on  a.account_master_id__c = o.account_master_id__c
left join user u on o.csm_owner__c = u.id 
where
YEAR (TO_DATE (churn_date__c)) = 2024
and 
(
(a.name not like '%Mcdonalds%' and  o.type in ('Renewal', 'Renewal/Upsell'))

or (o.type = 'Terminated' and o.stagename = 'Closed Won')

and change_in_arr_in_usd__c < 0 )
