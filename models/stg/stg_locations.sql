{{
    config(
        materialized = 'table',
        tags = ['stg']
    )
}}

select
    LOCATION_ID,
    CITY,
    STATE_PROVINCE,
    COUNTRY_ID,
    current_timestamp as LOAD_TIME
from {{ source('hr','src_locations') }}
