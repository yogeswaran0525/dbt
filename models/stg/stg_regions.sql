{{
    config(
        materialized='table',
        tags =['stg']
    )
}}

select
    REGION_ID,
    REGION_NAME,
    current_timestamp as LOAD_TIME
from {{ source('hr','src_regions') }}
where REGION_ID is not null