{{
    config(
        materialized = 'incremental',
        unique_key = 'EMPLOYEE_ID'
    )
}}

select
    EMPLOYEE_ID,
    FIRST_NAME || ' ' ||LAST_NAME as NAME,
    EMAIL,
    PHONE_NUMBER,
    HIRE_DATE,
    JOB_ID,
    SALARY,
    COMMISSION_PCT,
    MANAGER_ID,
    DEPARTMENT_ID,
    current_timestamp as  LOAD_TIME
from {{ref('stg_employees')}}

{% if is_incremental() %}

where LOAD_TIME > (select coalesce(max(LOAD_TIME),'1099-01-01 00:00:')from {{this}})

{% endif %}