{{
    config(
        materialized='incremental',
        unique_key = 'location_id',
        incremental_strategy = 'delete+insert',
        tags = ['dim']
    )
}}

SELECT
    location_id,
    INITCAP(city) AS city,
    INITCAP(state_province) AS state,
    country_id,
    CONCAT(city, ', ', state_province) AS full_location,
    CURRENT_TIMESTAMP AS load_time
FROM {{ ref('stg_locations') }}

{% if is_incremental() %}

{{ incr() }}

{% endif %}