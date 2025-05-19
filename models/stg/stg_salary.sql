{{
    config(
        materialized='table',
        database = 'dev',
        schema = 'stg'
    )
}}

select
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    JOB_TITLE,
    DEPARTMENT_NAME,
    CITY,
    COUNTRY_NAME,
    REGION_NAME,
    SALARY_DATE,
    HRA,
    ALLOWANCES,
    PF,
    current_timestamp as LOAD_TIME
from {{ source('hr','src_salary') }}
where EMPLOYEE_ID is not null