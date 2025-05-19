{{
    config(
        materialized = 'table',
        tags = ['stg']
    )
}}
select
    DEPARTMENT_ID,
    DEPARTMENT_NAME,
    MANAGER_ID,
    LOCATION_ID,
    current_timestamp as LOAD_TIME
from {{ source('hr','src_departments') }}
where DEPARTMENT_ID is not null