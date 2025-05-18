{% snapshot emp_snapshot %}

{{
    config(
        target_schema = 'dev',
        unique_key = 'EMPLOYEE_ID',
        strategy = 'timestamp',
        updated_at = 'LOAD_TIME',
        invalidate_hard_deletes = 'true'
    )
}}

select
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    LOAD_TIME
from {{ source('hr','src_employees') }}

{% endsnapshot %}