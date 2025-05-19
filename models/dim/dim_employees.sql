{{
    config(
        materialized='incremental',
        unique_key = 'EMPLOYEE_ID',
        incremental_strategy = 'delete+insert',
        tags = ['dim'],
        schema = 'dim'
    )
}}

select
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PHONE_NUMBER,
    HIRE_DATE,
    JOB_ID,
    SALARY,
    COMMISSION_PCT,
    MANAGER_ID,
    DEPARTMENT_ID,
    current_timestamp as LOAD_TIME
from {{ ref('stg_employees') }}

{% if is_incremental() %}

{{ incr() }}

{% endif %}