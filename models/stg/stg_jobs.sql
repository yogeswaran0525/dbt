{{
    config(
        materialized='table',
        tags = ['stg']
    )
}}

select
    JOB_ID,
    JOB_TITLE,
    MIN_SALARY,
    MAX_SALARY,
    current_timestamp as LOAD_TIME
from {{ source('hr','src_jobs') }}
where JOB_ID is not null