{{
    config(
        materialized = 'incremental',
        incremental_stratergies = 'insert_overwrite',
        unique_key = 'EMPLOYEE_ID',
        partition_by = {'field':'LOAD_TIME','data_type':'timestamp'}
    )
}}

select
    {{ dbt_utils.generate_surrogate_key(['EMPLOYEE_ID', 'FIRST_NAME']) }} as surrogate_key,
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
    current_timestamp as  LOAD_TIME
from {{ source('hr','src_employees') }} as src

{% if is_incremental() %}

    where src.LOAD_TIME > dateadd(day, -7, current_timestamp)

{% endif %}