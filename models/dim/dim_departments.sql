{{
    config(
        materialized='incremental',
        unique_key = 'department_id',
        incremental_strategy = 'delete+insert',
        tags = ['dim']
)

}}

SELECT
    department_id,
    INITCAP(department_name) AS department_name,
    manager_id,
    location_id,
    CURRENT_TIMESTAMP AS load_time
FROM {{ ref('stg_departments') }}

{% if is_incremental() %}

{{ incr()}}

{% endif %}