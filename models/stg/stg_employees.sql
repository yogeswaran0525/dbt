{{
    config(
        materialized = 'table',
        database = 'dev',
        schema = 'stg',
        tags = ['stg']
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
from {{ source('hr','src_employees') }}